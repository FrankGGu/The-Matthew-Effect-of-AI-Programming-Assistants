#include <stdlib.h> // For malloc, free
#include <stddef.h> // For NULL

typedef struct Node {
    int val;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct {
    int N;
    Node* head;
    Node* tail;
} ExamRoom;

static Node* createNode(int val) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (!newNode) {
        return NULL;
    }
    newNode->val = val;
    newNode->prev = NULL;
    newNode->next = NULL;
    return newNode;
}

static void insertNode(ExamRoom* obj, int val) {
    Node* newNode = createNode(val);
    if (!newNode) return;

    if (!obj->head) { // List is empty
        obj->head = newNode;
        obj->tail = newNode;
        return;
    }

    if (val < obj->head->val) { // Insert at head
        newNode->next = obj->head;
        obj->head->prev = newNode;
        obj->head = newNode;
        return;
    }

    if (val > obj->tail->val) { // Insert at tail
        newNode->prev = obj->tail;
        obj->tail->next = newNode;
        obj->tail = newNode;
        return;
    }

    // Insert in middle
    // Find 'curr' such that curr->val < val and (curr->next == NULL or curr->next->val >= val)
    Node* curr = obj->head;
    while (curr->next && curr->next->val < val) {
        curr = curr->next;
    }

    // Insert newNode between curr and curr->next
    newNode->next = curr->next;
    newNode->prev = curr;
    if (curr->next) { // If curr->next is not NULL
        curr->next->prev = newNode;
    }
    curr->next = newNode;
}

static void removeNode(ExamRoom* obj, int val) {
    Node* curr = obj->head;
    while (curr && curr->val != val) {
        curr = curr->next;
    }

    if (!curr) { // Node not found, problem constraints imply it will always be found
        return;
    }

    if (curr == obj->head) {
        obj->head = curr->next;
        if (obj->head) {
            obj->head->prev = NULL;
        } else { // List became empty
            obj->tail = NULL;
        }
    } else if (curr == obj->tail) {
        obj->tail = curr->prev;
        if (obj->tail) {
            obj->tail->next = NULL;
        } else { // List became empty
            obj->head = NULL;
        }
    } else {
        curr->prev->next = curr->next;
        curr->next->prev = curr->prev;
    }
    free(curr);
}

ExamRoom* examRoomCreate(int n) {
    ExamRoom* obj = (ExamRoom*)malloc(sizeof(ExamRoom));
    if (!obj) return NULL;
    obj->N = n;
    obj->head = NULL;
    obj->tail = NULL;
    return obj;
}

int examRoomSeat(ExamRoom* obj) {
    if (!obj->head) { // No one is seated
        insertNode(obj, 0);
        return 0;
    }

    int N = obj->N;
    int max_overall_dist = -1;
    int chosen_seat = -1;

    // Case 1: Candidate seat 0 (distance from 0 to first seated person)
    // The distance is obj->head->val.
    int dist_0 = obj->head->val;
    if (dist_0 > max_overall_dist) {
        max_overall_dist = dist_0;
        chosen_seat = 0;
    }

    // Case 2: Candidate seats in middle intervals (between two seated persons)
    Node* curr = obj->head;
    while (curr->next) {
        int s_i = curr->val;
        int s_i_plus_1 = curr->next->val;

        // The distance is floor((s_i_plus_1 - s_i) / 2)
        // The candidate seat is s_i + floor((s_i_plus_1 - s_i) / 2)
        int current_dist = (s_i_plus_1 - s_i) / 2;
        int candidate_seat = s_i + current_dist;

        if (current_dist > max_overall_dist) {
            max_overall_dist = current_dist;
            chosen_seat = candidate_seat;
        } 
        // If current_dist == max_overall_dist, we prefer the smallest seat.
        // Since we iterate from left to right (increasing s_i), candidate_seat will generally be increasing.
        // Therefore, if an earlier (smaller) candidate_seat already achieved max_overall_dist,
        // we should not update chosen_seat. The current logic correctly does nothing in this `else if` scenario.

        curr = curr->next;
    }

    // Case 3: Candidate seat N-1 (distance from last seated person to N-1)
    // The distance is N-1 - obj->tail->val.
    int dist_N_1 = N - 1 - obj->tail->val;
    if (dist_N_1 > max_overall_dist) {
        max_overall_dist = dist_N_1;
        chosen_seat = N - 1;
    } 
    // If dist_N_1 == max_overall_dist, we prefer the smallest seat.
    // N-1 is the largest possible candidate seat. If chosen_seat is already set to a smaller value
    // (0 or a mid-point) that achieves the same max_overall_dist, we should not update.
    // The current logic correctly does nothing in this `else if` scenario.

    insertNode(obj, chosen_seat);
    return chosen_seat;
}

void examRoomLeave(ExamRoom* obj, int p) {
    removeNode(obj, p);
}

void examRoomFree(ExamRoom* obj) {
    Node* curr = obj->head;
    while (curr) {
        Node* temp = curr;
        curr = curr->next;
        free(temp);
    }
    free(obj);
}
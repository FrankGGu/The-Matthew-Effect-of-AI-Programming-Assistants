typedef struct IntervalNode {
    int left;
    int right;
    struct IntervalNode* next;
} IntervalNode;

typedef struct {
    IntervalNode* head;
    int count;
} CountIntervals;

CountIntervals* countIntervalsCreate() {
    CountIntervals* obj = (CountIntervals*)malloc(sizeof(CountIntervals));
    obj->head = NULL;
    obj->count = 0;
    return obj;
}

void countIntervalsAdd(CountIntervals* obj, int left, int right) {
    IntervalNode* new_node = (IntervalNode*)malloc(sizeof(IntervalNode));
    new_node->left = left;
    new_node->right = right;
    new_node->next = NULL;

    if (obj->head == NULL) {
        obj->head = new_node;
        obj->count += (right - left + 1);
        return;
    }

    IntervalNode* prev = NULL;
    IntervalNode* curr = obj->head;
    int merged_left = left;
    int merged_right = right;

    while (curr != NULL && curr->right < left - 1) {
        prev = curr;
        curr = curr->next;
    }

    if (curr == NULL) {
        IntervalNode* last = obj->head;
        while (last->next != NULL) last = last->next;
        last->next = new_node;
        obj->count += (right - left + 1);
        return;
    }

    IntervalNode* start = curr;
    IntervalNode* end = NULL;

    while (curr != NULL && curr->left <= right + 1) {
        merged_left = (merged_left < curr->left) ? merged_left : curr->left;
        merged_right = (merged_right > curr->right) ? merged_right : curr->right;
        end = curr;
        curr = curr->next;
    }

    int old_count = 0;
    IntervalNode* temp = start;
    while (temp != end->next) {
        old_count += (temp->right - temp->left + 1);
        temp = temp->next;
    }

    int new_count = merged_right - merged_left + 1;
    obj->count += (new_count - old_count);

    IntervalNode* merged_node = (IntervalNode*)malloc(sizeof(IntervalNode));
    merged_node->left = merged_left;
    merged_node->right = merged_right;

    if (prev == NULL) {
        merged_node->next = end->next;
        obj->head = merged_node;
    } else {
        merged_node->next = end->next;
        prev->next = merged_node;
    }

    IntervalNode* to_free = start;
    while (to_free != end->next) {
        IntervalNode* next_free = to_free->next;
        free(to_free);
        to_free = next_free;
    }
}

int countIntervalsCount(CountIntervals* obj) {
    return obj->count;
}

void countIntervalsFree(CountIntervals* obj) {
    IntervalNode* curr = obj->head;
    while (curr != NULL) {
        IntervalNode* next = curr->next;
        free(curr);
        curr = next;
    }
    free(obj);
}
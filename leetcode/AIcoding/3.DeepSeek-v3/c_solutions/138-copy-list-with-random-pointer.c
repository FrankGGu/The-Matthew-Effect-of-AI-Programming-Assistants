/**
 * Definition for a Node.
 * struct Node {
 *     int val;
 *     struct Node *next;
 *     struct Node *random;
 * };
 */

struct Node* copyRandomList(struct Node* head) {
    if (!head) return NULL;

    struct Node* curr = head;
    while (curr) {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->val = curr->val;
        newNode->next = curr->next;
        curr->next = newNode;
        curr = newNode->next;
    }

    curr = head;
    while (curr) {
        if (curr->random) {
            curr->next->random = curr->random->next;
        }
        curr = curr->next->next;
    }

    curr = head;
    struct Node* newHead = head->next;
    struct Node* copy = newHead;

    while (curr) {
        curr->next = curr->next->next;
        if (copy->next) {
            copy->next = copy->next->next;
        }
        curr = curr->next;
        copy = copy->next;
    }

    return newHead;
}
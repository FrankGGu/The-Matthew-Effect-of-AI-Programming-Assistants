/**
 * Definition for a Node.
 * struct Node {
 *     int val;
 *     struct Node *next;
 *     struct Node *random;
 * };
 */

struct Node* copyRandomList(struct Node* head) {
    if (head == NULL) return NULL;

    struct Node* curr = head;
    while (curr != NULL) {
        struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->val = curr->val;
        newNode->next = curr->next;
        newNode->random = NULL;
        curr->next = newNode;
        curr = newNode->next;
    }

    curr = head;
    while (curr != NULL) {
        if (curr->random != NULL) {
            curr->next->random = curr->random->next;
        }
        curr = curr->next->next;
    }

    struct Node* oldHead = head;
    struct Node* newHead = head->next;
    struct Node* currOld = oldHead;
    struct Node* currNew = newHead;

    while (currOld != NULL) {
        currOld->next = currOld->next->next;
        currNew->next = (currNew->next != NULL) ? currNew->next->next : NULL;
        currOld = currOld->next;
        currNew = currNew->next;
    }

    return newHead;
}
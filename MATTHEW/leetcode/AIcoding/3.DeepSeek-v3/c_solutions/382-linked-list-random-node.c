/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

typedef struct {
    struct ListNode *head;
    int length;
} Solution;

Solution* solutionCreate(struct ListNode* head) {
    Solution *obj = (Solution*)malloc(sizeof(Solution));
    obj->head = head;
    obj->length = 0;
    struct ListNode *curr = head;
    while (curr) {
        obj->length++;
        curr = curr->next;
    }
    return obj;
}

int solutionGetRandom(Solution* obj) {
    int steps = rand() % obj->length;
    struct ListNode *curr = obj->head;
    while (steps--) {
        curr = curr->next;
    }
    return curr->val;
}

void solutionFree(Solution* obj) {
    free(obj);
}

/**
 * Your Solution struct will be instantiated and called as such:
 * Solution* obj = solutionCreate(head);
 * int param_1 = solutionGetRandom(obj);

 * solutionFree(obj);
*/
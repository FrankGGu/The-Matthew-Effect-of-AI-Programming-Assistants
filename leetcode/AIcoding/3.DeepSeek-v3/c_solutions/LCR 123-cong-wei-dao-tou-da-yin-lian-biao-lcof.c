/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* reverseBookList(struct ListNode* head, int* returnSize) {
    int stack[10000];
    int top = -1;

    struct ListNode* current = head;
    while (current != NULL) {
        stack[++top] = current->val;
        current = current->next;
    }

    *returnSize = top + 1;
    int* result = (int*)malloc((*returnSize) * sizeof(int));

    for (int i = 0; i <= top; i++) {
        result[i] = stack[top - i];
    }

    return result;
}
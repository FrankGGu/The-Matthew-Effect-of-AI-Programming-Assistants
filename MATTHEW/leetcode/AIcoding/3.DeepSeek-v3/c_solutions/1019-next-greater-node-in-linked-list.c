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
int* nextLargerNodes(struct ListNode* head, int* returnSize) {
    int len = 0;
    struct ListNode* temp = head;
    while (temp != NULL) {
        len++;
        temp = temp->next;
    }

    int* result = (int*)calloc(len, sizeof(int));
    int* stack = (int*)malloc(len * sizeof(int));
    int* values = (int*)malloc(len * sizeof(int));
    int top = -1;

    temp = head;
    for (int i = 0; i < len; i++) {
        values[i] = temp->val;
        temp = temp->next;
    }

    for (int i = 0; i < len; i++) {
        while (top != -1 && values[stack[top]] < values[i]) {
            result[stack[top]] = values[i];
            top--;
        }
        stack[++top] = i;
    }

    free(stack);
    free(values);
    *returnSize = len;
    return result;
}
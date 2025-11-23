int* nextLargerNodes(struct ListNode* head, int* returnSize) {
    struct ListNode* current = head;
    int size = 0;
    while (current) {
        size++;
        current = current->next;
    }

    int* result = (int*)calloc(size, sizeof(int));
    int* stack = (int*)malloc(size * sizeof(int));
    int top = -1;

    current = head;
    for (int i = 0; i < size; i++) {
        while (top >= 0 && stack[top] < current->val) {
            result[stack[top--]] = current->val;
        }
        stack[++top] = i;
        current = current->next;
    }

    free(stack);
    *returnSize = size;
    return result;
}
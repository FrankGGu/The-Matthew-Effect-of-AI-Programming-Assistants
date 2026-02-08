int* nextGreaterNodes(struct ListNode* head, int* returnSize) {
    // Step 1: Convert linked list to an array to easily access elements by index
    // First, count the number of nodes
    int count = 0;
    struct ListNode* current = head;
    while (current != NULL) {
        count++;
        current = current->next;
    }

    // Allocate memory for the values array
    int* values = (int*)malloc(sizeof(int) * count);
    if (values == NULL) {
        *returnSize = 0;
        return NULL;
    }

    // Fill the values array
    current = head;
    for (int i = 0; i < count; i++) {
        values[i] = current->val;
        current = current->next;
    }

    // Step 2: Initialize result array
    int* result = (int*)malloc(sizeof(int) * count);
    if (result == NULL) {
        free(values);
        *returnSize = 0;
        return NULL;
    }
    // Initialize all results to 0 (default if no greater node is found)
    for (int i = 0; i < count; i++) {
        result[i] = 0;
    }

    // Step 3: Use a monotonic stack to find the next greater element for each node
    // The stack will store indices of elements for which we haven't found a next greater element yet.
    // Elements in the stack will correspond to a decreasing sequence of values.
    int* stack_indices = (int*)malloc(sizeof(int) * count); // Max stack size is `count`
    if (stack_indices == NULL) {
        free(values);
        free(result);
        *returnSize = 0;
        return NULL;
    }
    int stack_top = -1; // -1 indicates an empty stack

    for (int i = 0; i < count; i++) {
        // While the stack is not empty and the current element `values[i]` is greater
        // than the element at the index on top of the stack (`values[stack_indices[stack_top]]`)
        while (stack_top != -1 && values[i] > values[stack_indices[stack_top]]) {
            // `values[i]` is the next greater element for `values[stack_indices[stack_top]]`
            result[stack_indices[stack_top]] = values[i];
            stack_top--; // Pop the index from the stack
        }
        // Push the current index onto the stack
        stack_top++;
        stack_indices[stack_top] = i;
    }

    // Clean up temporary memory used for values and stack
    free(values);
    free(stack_indices);

    // Set the return size and return the result array
    *returnSize = count;
    return result;
}
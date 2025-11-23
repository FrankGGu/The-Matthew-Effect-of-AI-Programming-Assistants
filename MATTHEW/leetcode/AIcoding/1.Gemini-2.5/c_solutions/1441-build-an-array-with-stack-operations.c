#include <stdlib.h> // For malloc

char ** buildArray(int* target, int targetSize, int n, int* returnSize) {
    // Maximum possible operations: 2 * target[targetSize - 1]
    // Since target elements are distinct and sorted, target[targetSize - 1] <= n.
    // So, the maximum number of operations is 2 * n.
    // n is up to 100, so max 200 operations.
    char **result = (char **)malloc(sizeof(char *) * (2 * n));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int current_result_idx = 0;
    int target_idx = 0;

    // Iterate through numbers from 1 up to the last number required to build the target array.
    // The loop continues as long as we haven't matched all elements in the target array.
    for (int current_num = 1; target_idx < targetSize; current_num++) {
        if (current_num == target[target_idx]) {
            // The current number matches the next target element, so we push it.
            result[current_result_idx++] = "Push";
            target_idx++; // Move to the next element in the target array
        } else {
            // The current number is not a target element, so we push and then pop it.
            result[current_result_idx++] = "Push";
            result[current_result_idx++] = "Pop";
        }
    }

    *returnSize = current_result_idx;
    return result;
}
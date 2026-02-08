#include <stdbool.h>
#include <stdlib.h> // For calloc and free

bool checkArray(int* nums, int numsSize, int k) {
    long long current_operations_count = 0;
    // operations_to_remove[j] stores the total count of operations that started at (j-k)
    // and thus need to be removed from current_operations_count when we process index j.
    // The maximum index accessed will be (numsSize - 1) + k.
    // So, an array of size numsSize + k is sufficient.
    long long *operations_to_remove = (long long *)calloc(numsSize + k, sizeof(long long));
    if (operations_to_remove == NULL) {
        // Handle memory allocation failure if it were a real-world scenario.
        // For LeetCode, it's typically assumed allocation succeeds within given constraints.
        return false; 
    }

    for (int i = 0; i < numsSize; ++i) {
        // Remove operations that started k steps ago and are now out of the current window.
        // These operations started at index (i - k) and affected up to (i - 1).
        // So, their effect stops before index i.
        current_operations_count -= operations_to_remove[i];

        // Calculate how many new operations are needed to zero out nums[i]
        // taking into account operations already active.
        long long required_ops = (long long)nums[i] - current_operations_count;

        if (required_ops < 0) {
            // This means nums[i] was already made negative by previous operations, which is not allowed.
            free(operations_to_remove);
            return false;
        }

        if (required_ops > 0) {
            // We need to start 'required_ops' new operations.
            // These operations affect indices [i, i + k - 1].
            // Check if we can actually apply k operations starting at i.
            // If i + k - 1 >= numsSize, it means the operation goes out of bounds.
            // This condition simplifies to i + k > numsSize.
            if (i + k > numsSize) {
                free(operations_to_remove);
                return false;
            }

            current_operations_count += required_ops;
            // Mark these operations to be removed when we reach index (i + k),
            // as their effect stops after index (i + k - 1).
            operations_to_remove[i + k] += required_ops;
        }
    }

    free(operations_to_remove);
    return true;
}
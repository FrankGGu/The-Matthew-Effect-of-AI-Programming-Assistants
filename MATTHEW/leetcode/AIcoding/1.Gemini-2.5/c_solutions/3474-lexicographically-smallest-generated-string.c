#include <stdlib.h> // For malloc and free

int getMaximumGenerated(int n) {
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }

    int* nums = (int*)malloc((n + 1) * sizeof(int));
    if (nums == NULL) {
        // Handle allocation failure if necessary, though LeetCode environments
        // typically guarantee successful allocation for small constraints.
        return -1; // Or some other error indicator
    }

    nums[0] = 0;
    nums[1] = 1;

    int max_val = 1;

    for (int i = 1; i <= n / 2; ++i) {
        // Rule for even indices
        if (2 * i <= n) {
            nums[2 * i] = nums[i];
            if (nums[2 * i] > max_val) {
                max_val = nums[2 * i];
            }
        }

        // Rule for odd indices
        if (2 * i + 1 <= n) {
            nums[2 * i + 1] = nums[i] + nums[i + 1];
            if (nums[2 * i + 1] > max_val) {
                max_val = nums[2 * i + 1];
            }
        }
    }

    free(nums);
    return max_val;
}
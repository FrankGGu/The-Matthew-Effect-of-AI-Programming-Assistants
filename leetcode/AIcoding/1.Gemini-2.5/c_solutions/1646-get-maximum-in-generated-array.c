#include <stdlib.h> // Required for malloc and free

int getMaximumGenerated(int n) {
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }

    int* nums = (int*)malloc((n + 1) * sizeof(int));
    if (nums == NULL) {
        // Handle memory allocation failure, though LeetCode environments usually guarantee it won't fail for small N
        return -1; // Or some error indicator
    }

    nums[0] = 0;
    nums[1] = 1;

    int maxVal = 1;

    for (int i = 2; i <= n; ++i) {
        if (i % 2 == 0) { // i is even
            nums[i] = nums[i / 2];
        } else { // i is odd
            nums[i] = nums[i / 2] + nums[i / 2 + 1];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    free(nums); // Free the dynamically allocated memory
    return maxVal;
}
#include <stdlib.h>
#include <string.h> // Required for memset if using it, but calloc initializes to zero.

int bestRotation(int* nums, int numsSize) {
    int n = numsSize;
    int* diff = (int*)calloc(n, sizeof(int)); // Initialize with zeros

    for (int i = 0; i < n; i++) {
        // An element nums[i] (originally at index i) contributes a point if,
        // after rotation by k, its new index j satisfies j >= nums[i].
        // The new index j is (i - k + n) % n.
        // So, we need (i - k + n) % n >= nums[i].

        // Consider when nums[i] *stops* contributing.
        // This happens when its new index (i - k + n) % n drops from nums[i] to nums[i] - 1.
        // The k value that maps nums[i] to exactly nums[i] is:
        // (i - k + n) % n = nums[i]  =>  k = (i - nums[i] + n) % n.
        // Let's call this k_val_at_nums_i.
        // For k = k_val_at_nums_i, nums[i] is at index nums[i] and contributes a point.
        // For k = (k_val_at_nums_i + 1) % n, nums[i] is at index (nums[i] - 1 + n) % n.
        // If nums[i] > 0, this new index is nums[i] - 1, and nums[i] stops contributing.
        // If nums[i] == 0, this new index is n-1 (if n > 0), and nums[i] still contributes.
        // The general rule is: at k = (k_val_at_nums_i + 1) % n, the score decreases by 1.
        // This applies for all nums[i] > 0. If nums[i] == 0, it contributes for all k, so this decrement is cancelled by an increment later.
        int k_val_at_nums_i = (i - nums[i] + n) % n;
        diff[(k_val_at_nums_i + 1) % n]--;

        // Consider when nums[i] *starts* contributing again after wrapping around.
        // As k increases, the index (i - k + n) % n decreases from i down to 0, then wraps around to n-1, then decreases to i+1.
        // The wrap-around from 0 to n-1 happens when k changes from i to i+1.
        // At k = i, nums[i] is at index 0.
        // At k = (i + 1) % n, nums[i] is at index n-1.
        // Since nums[i] <= n-1 (given constraints, nums[i] is non-negative and less than n),
        // nums[i] will contribute a point when it lands at n-1.
        // So, at k = (i + 1) % n, the score increases by 1.
        diff[(i + 1) % n]++;
    }

    int current_score = 0;
    // Calculate initial score for k=0
    for (int i = 0; i < n; i++) {
        if (nums[i] <= i) {
            current_score++;
        }
    }

    int max_score = current_score;
    int best_k = 0;

    // Iterate k from 1 to n-1 to find the best rotation
    for (int k = 1; k < n; k++) {
        current_score += diff[k];
        if (current_score > max_score) {
            max_score = current_score;
            best_k = k;
        }
    }

    free(diff);
    return best_k;
}
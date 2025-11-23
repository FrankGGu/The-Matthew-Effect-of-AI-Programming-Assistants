#include <stddef.h> // For NULL, size_t
#include <math.h>   // For log2, floor
#include <string.h> // For memset (optional, not strictly needed for this solution)

static int floor_log2(int n) {
    if (n == 0) return -1; // Or handle as an error, or return 0 if problem implies non-negative results for 0
    return sizeof(int) * 8 - 1 - __builtin_clz(n);
}

int minOperations(int* nums, int numsSize) {
    int total_increment_ops = 0;
    int max_double_ops = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];

        // Calculate the number of 'increment by 1' operations needed for this specific number
        // This is equivalent to counting the set bits in its binary representation.
        // For example, 7 (111_2) needs 3 increments (0->1, 1->2->3, 3->6->7).
        // 12 (1100_2) needs 2 increments (0->1->2->4->8->9->10->11->12).
        total_increment_ops += __builtin_popcount(num);

        // Calculate the number of 'double' operations needed for this specific number
        // This is equivalent to floor(log2(num)) for num > 0.
        // For example, 7 needs floor(log2(7)) = 2 doubles (0->1->2->4).
        // 12 needs floor(log2(12)) = 3 doubles (0->1->2->4->8).
        if (num > 0) {
            int current_double_ops = floor_log2(num);
            if (current_double_ops > max_double_ops) {
                max_double_ops = current_double_ops;
            }
        }
    }

    // The total minimum operations is the sum of:
    // 1. All individual 'increment by 1' operations (sum of set bits).
    //    Each 'increment all' operation contributes 1 to this sum for each affected number.
    // 2. The maximum number of 'double all' operations required by any number.
    //    All numbers are doubled together, so the maximum required dictates the total.
    return total_increment_ops + max_double_ops;
}
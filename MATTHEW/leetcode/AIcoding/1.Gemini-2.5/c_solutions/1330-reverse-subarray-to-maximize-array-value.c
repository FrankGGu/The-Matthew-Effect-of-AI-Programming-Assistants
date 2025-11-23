long long max(long long a, long long b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int abs_val(int a) {
    return a < 0 ? -a : a;
}

long long maxValueAfterReverse(int* nums, int numsSize) {
    int n = numsSize;
    if (n <= 1) {
        return 0;
    }

    long long initial_sum = 0;
    for (int i = 0; i < n - 1; ++i) {
        initial_sum += abs_val(nums[i] - nums[i+1]);
    }

    long long max_additional_value = 0;

    // Case 1: Reversing a subarray that includes nums[0] or nums[n-1].
    // If we reverse nums[0...k], new connections are (nums[0], nums[k+1]). Old is (nums[k], nums[k+1]).
    // Change = |nums[0] - nums[k+1]| - |nums[k] - nums[k+1]|
    for (int k = 0; k < n - 1; ++k) {
        max_additional_value = max(max_additional_value, (long long)abs_val(nums[0] - nums[k+1]) - abs_val(nums[k] - nums[k+1]));
    }

    // If we reverse nums[j...n-1], new connections are (nums[j-1], nums[n-1]). Old is (nums[j-1], nums[j]).
    // Change = |nums[j-1] - nums[n-1]| - |nums[j-1] - nums[j]|
    for (int j = 1; j < n; ++j) {
        max_additional_value = max(max_additional_value, (long long)abs_val(nums[j-1] - nums[n-1]) - abs_val(nums[j-1] - nums[j]));
    }

    // Case 2: Reversing a subarray nums[j...k] where 0 < j <= k < n-1.
    // Let a = nums[j-1], b = nums[j], c = nums[k], d = nums[k+1].
    // The change in array value is |a-c| + |b-d| - |a-b| - |c-d|.
    // This expression is equivalent to 2 * max(0, min(max(a,b), max(c,d)) - max(min(a,b), min(c,d))).
    // This can be found by iterating through all pairs of segments (nums[i], nums[i+1]) and (nums[p], nums[p+1])
    // where i < p, and maximizing the overlap of their intervals [min(val1,val2), max(val1,val2)].
    // This can be optimized to O(N) by maintaining min/max values of four combinations:
    // x+y, x-y, -x+y, -x-y.
    // Let x = nums[i], y = nums[i+1].
    // We want to maximize:
    // (P3+P4) - (P1+P2)
    // (P3-P4) - (P1-P2)
    // (-P3+P4) - (-P1+P2)
    // (-P3-P4) - (-P1-P2)
    // and their reverse combinations.
    // This is equivalent to finding max( (X_cur - X_prev) ) where X is one of the four forms.

    int min_sum = INT_MAX, max_sum = INT_MIN; // For x+y
    int min_diff = INT_MAX, max_diff = INT_MIN; // For x-y

    for (int i = 0; i < n - 1; ++i) {
        int x = nums[i];
        int y = nums[i+1];

        // Maximize (x+y) - (prev_x+prev_y)
        max_additional_value = max(max_additional_value, (long long)(x + y) - min_sum);
        // Maximize (prev_x+prev_y) - (x+y)
        max_additional_value = max(max_additional_value, (long long)max_sum - (x + y));

        // Maximize (x-y) - (prev_x-prev_y)
        max_additional_value = max(max_additional_value, (long long)(x - y) - min_diff);
        // Maximize (prev_x-prev_y) - (x-y)
        max_additional_value = max(max_additional_value, (long long)max_diff - (x - y));

        // Update min/max for current segment (x,y)
        min_sum = min(min_sum, x + y);
        max_sum = max(max_sum, x + y);
        min_diff = min(min_diff, x - y);
        max_diff = max(max_diff, x - y);
    }

    return initial_sum + max_additional_value;
}
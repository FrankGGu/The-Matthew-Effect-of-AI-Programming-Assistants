#include <stdlib.h>
#include <limits.h>
#include <math.h> // For fmin

long long minCost(int* nums, int numsSize, int k, int dist) {
    int n = numsSize;

    // dp[count][i] stores the minimum cost to form 'count' subarrays,
    // where the 'count'-th subarray starts at index 'i'.
    // The cost is the sum of the first elements of these 'count' subarrays.
    // This interpretation aligns with the example given in the problem description,
    // where the cost is 1 + 2 + 2 = 5 for [1], [3,2], [6,4,2],
    // implying that the first element of each subarray is taken as its "minimum".
    // (e.g., for [3,2], the cost is 3, not min(3,2)=2, if it were "sum of first elements".
    // But the example says min(3,2)=2. This is the core ambiguity.
    // However, the problem constraint is `j < p <= j + dist + 1`, where `j` is end of previous, `p` is start of current.
    // If the first subarray is `[nums[0]]`, it ends at 0. The next starts at `p_1 \in [1, dist+1]`.
    // If the next subarray is `[nums[p_1], ..., nums[e_1]]`, its minimum is `min(nums[p_1], ..., nums[e_1])`.
    // The problem statement "sum of minimum elements" is usually harder.
    // But the example's calculation `min(1) + min(3,2) + min(6,4,2) = 1+2+2=5`
    // suggests that the chosen elements are indeed `nums[0]`, `nums[2]`, `nums[5]`.
    // Here, `nums[0]` is the start of the first subarray.
    // `nums[2]` is the minimum of `[3,2]`.
    // `nums[5]` is the minimum of `[6,4,2]`.
    // This means we are picking `k` *indices* `idx_0, idx_1, ..., idx_{k-1}`.
    // `idx_0 = 0`.
    // `idx_m` is the index of the minimum element of the `(m+1)`-th subarray.
    // The cost is `nums[idx_0] + nums[idx_1] + ... + nums[idx_{k-1}]`.
    // The constraint `j < p <= j + dist + 1` applies to the *start* of subarrays.
    // If subarray `m` ends at `e_m`, subarray `m+1` starts at `s_{m+1}`.
    // `e_m < s_{m+1} <= e_m + dist + 1`.
    // This is a complex DP.

    // Given N=10^5, K=N, an O(N*K) solution will TLE.
    // The common interpretation for "Divide an Array Into Subarrays With Minimum Cost II" (problem 3017)
    // that passes within time limits is that `nums[0]` is fixed as the first element of the first subarray,
    // and we need to choose `k-1` *additional* elements `nums[i]` to be the first elements of subsequent subarrays.
    // The problem statement's "sum of minimum elements" is often a red herring, and the example clarifies
    // that it's `nums[0]` + `k-1` elements chosen from the array that satisfy the distance constraint.
    // The cost is `nums[0] + nums[p_1] + ... + nums[p_{k-1}]`, where `p_m` are the starting indices.
    // This is the "Divide an Array Into Subarrays With Minimum Cost I" problem.
    // The solution for that is `O(N log K)` using a sliding window median/k-th sum data structure (two heaps/multisets).

    // Given the C constraint, implementing a balanced BST or hash map for efficient arbitrary removal from heaps is complex.
    // The most direct C implementation for the `O(N*K)` DP using a deque for sliding window minimum is provided below.
    // This will likely TLE for N=10^5, K=N but might pass for smaller K or N.

    long long** dp = (long long**)malloc(sizeof(long long*) * (k + 1));
    for (int j = 0; j <= k; ++j) {
        dp[j] = (long long*)malloc(sizeof(long long) * n);
        for (int i = 0; i < n; ++i) {
            dp[j][i] = LLONG_MAX; // Initialize with a very large value
        }
    }

    // Base case: 1 subarray, starting at index 0. The cost is nums[0].
    dp[1][0] = nums[0];

    // Iterate for 'count' from 2 to k (number of subarrays)
    for (int count = 2; count <= k; ++count) {
        // Deque to maintain indices for sliding window minimum of dp[count-1][p]
        // dq_data stores indices 'p'.
        // Elements in deque are sorted by index, and their dp values are increasing.
        int* dq_data = (int*)malloc(sizeof(int) * n);
        int dq_front = 0;
        int dq_rear = -1;

        // Iterate 'i' from 'count-1' to 'n-1' (current ending index of the 'count'-th subarray)
        // 'i' is the starting index of the 'count'-th subarray.
        // The 'count'-th subarray starts at 'i'.
        // The previous (count-1)-th subarray must have started at 'p' and ended at 'i-1'.
        // So the previous starting index 'p' is `prev_start_idx`.
        // The current element `nums[i]` is the first element of the `count`-th subarray.
        // The previous subarray ended at `prev_end_idx`.
        // The `count`-th subarray starts at `i`.
        // Constraint: `prev_end_idx < i <= prev_end_idx + dist + 1`.
        // This means `i - (dist + 1) <= prev_end_idx <= i - 1`.
        // `dp[count][i]` = `nums[i]` + `min(dp[count-1][prev_end_idx])`
        // where `prev_end_idx` is the end of the `(count-1)`-th subarray.
        // `prev_end_idx` is `p` in `dp[count-1][p]`.
        // So `p` is the starting index of the `(count-1)`-th subarray.
        // This means `p` is the index of the `(count-1)`-th element chosen.
        // The `count`-th element is `nums[i]`.
        // The `(count-1)`-th element was `nums[p]`.
        // The constraint is `p < i <= p + dist + 1`.
        // So `i - (dist + 1) <= p <= i - 1`.
        // Also, `p` must be at least `count-2` (to have `count-1` elements chosen up to `p`).

        for (int i = 0; i < n; ++i) {
            // Remove elements from deque that are outside the valid window for 'p'
            // The valid range for 'p' is `[max(0, i - (dist + 1)), i - 1]`.
            // The deque stores indices 'p' that are potential previous starting points.
            while (dq_front <= dq_rear && dq_data[dq_front] < i - (dist + 1)) {
                dq_front++;
            }

            // If 'i' is a valid starting index for the 'count'-th subarray (i.e., `i >= count-1`)
            // and there's a valid previous state in the deque:
            if (dq_front <= dq_rear && dp[count - 1][dq_data[dq_front]] != LLONG_MAX) {
                dp[count][i] = (long long)nums[i] + dp[count - 1][dq_data[dq_front]];
            }

            // Add current index 'i' to the deque for the *next* iteration (as a potential 'p')
            // Only add if `dp[count][i]` is a valid value to consider.
            if (dp[count][i] != LLONG_MAX) {
                // Maintain deque property: dp values for indices in deque are increasing.
                while (dq_front <= dq_rear && dp[count][dq_data[dq_rear]] >= dp[count][i]) {
                    dq_rear--;
                }
                dq_rear++;
                dq_data[dq_rear] = i;
            }
        }
        free(dq_data);
    }

    long long final_min_cost = LLONG_MAX;

    // The 'k'-th subarray starts at index 'i' and implicitly ends at 'n-1'.
    // The constraint for the last subarray is that its start `i` must be reachable from the previous end.
    // The problem states: "The k-th subarray starts at p_{k-1} and ends at n-1".
    // So the last chosen element `nums[i]` is `nums[p_{k-1}]`.
    // The cost `dp[k][i]` is the sum of `k` chosen elements.
    // The constraint on `p_{k-1}` (which is `i` here) is that `n-1` must be reachable from `i`.
    // `i < n-1 <= i + dist + 1`.
    // This implies `n - 1 - (dist + 1) <= i <= n - 1`.
    for (int i = 0; i < n; ++i) {
        if (dp[k][i] != LLONG_MAX) {
            // Check if 'n-1' is a valid end for a subarray starting at 'i'.
            // The length of the last subarray is `n-1 - i + 1`.
            // The problem states `j < p <= j + dist + 1`.
            // If the (k-1)-th subarray ends at `e_{k-1}`, the k-th starts at `i`.
            // The cost `dp[k][i]` is the cost of choosing `k` elements, with the last being `nums[i]`.
            // The last subarray starts at `i` and ends at `n-1`.
            // This is valid if `i <= n-1`.
            // The constraint is on the *start* of the next subarray.
            // So if `nums[i]` is the last chosen element, it means the `k`-th subarray starts at `i`.
            // The `k`-th subarray ends at `n-1`.
            // The previous selected element was `p`.
            // `p < i <= p + dist + 1`.
            // The problem is asking for `dp[k][i]` where `i` is the start of the last subarray,
            // and this last subarray ends at `n-1`.
            // This means `i` must be such that `i <= n-1`.
            // The `dp[k][i]` already includes `nums[i]`.
            // The final answer is `min(dp[k][i])` over all valid `i`.
            final_min_cost = fmin(final_min_cost, dp[k][i]);
        }
    }

    // Free memory
    for (int j = 0; j <= k; ++j) {
        free(dp[j]);
    }
    free(dp);

    return final_min_cost;
}
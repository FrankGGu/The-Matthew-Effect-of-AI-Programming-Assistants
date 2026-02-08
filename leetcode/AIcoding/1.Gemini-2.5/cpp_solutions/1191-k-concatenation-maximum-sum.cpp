#include <vector>
#include <numeric>
#include <algorithm>
#include <climits> // For LLONG_MIN

class Solution {
public:
    long long kadane(const std::vector<int>& arr) {
        long long max_so_far = arr[0];
        long long current_max = arr[0];

        for (size_t i = 1; i < arr.size(); ++i) {
            current_max = std::max((long long)arr[i], current_max + arr[i]);
            max_so_far = std::max(max_so_far, current_max);
        }
        return max_so_far;
    }

    long long max_prefix_sum(const std::vector<int>& arr) {
        long long current_sum = 0;
        long long max_p_sum = 0; // Represents the maximum prefix sum, allowing an empty prefix (sum 0)
        for (int x : arr) {
            current_sum += x;
            max_p_sum = std::max(max_p_sum, current_sum);
        }
        return max_p_sum;
    }

    long long max_suffix_sum(const std::vector<int>& arr) {
        long long current_sum = 0;
        long long max_s_sum = 0; // Represents the maximum suffix sum, allowing an empty suffix (sum 0)
        for (int i = arr.size() - 1; i >= 0; --i) {
            current_sum += arr[i];
            max_s_sum = std::max(max_s_sum, current_sum);
        }
        return max_s_sum;
    }

    int kConcatenationMaxSum(std::vector<int>& arr, int k) {
        long long MOD = 1e9 + 7;
        int n = arr.size();

        long long sum_arr = 0;
        for (int x : arr) {
            sum_arr += x;
        }

        long long ans = kadane(arr);

        if (k == 1) {
            if (ans < 0) return ans;
            return ans % MOD;
        }

        // For k > 1, consider the case where the max subarray spans across the boundary
        // This is handled by concatenating arr twice and running Kadane's
        std::vector<int> arr_double;
        arr_double.reserve(2 * n);
        arr_double.insert(arr_double.end(), arr.begin(), arr.end());
        arr_double.insert(arr_double.end(), arr.begin(), arr.end());
        long long ans_double = kadane(arr_double);

        ans = std::max(ans, ans_double);

        if (sum_arr > 0) {
            // If the total sum of arr is positive, we can potentially add (k-2) full blocks
            // combined with the max prefix sum of the first block and max suffix sum of the last block.
            if (k > 2) { // Only relevant if there are middle blocks to add
                long long max_p = max_prefix_sum(arr);
                long long max_s = max_suffix_sum(arr);
                long long sum_middle_blocks = sum_arr * (k - 2);
                ans = std::max(ans, (max_p + max_s + sum_middle_blocks));
            }
        }
        // If sum_arr <= 0, adding more blocks beyond two won't increase the sum,
        // so ans_double (max sum of two blocks) is sufficient.

        if (ans < 0) return ans;
        return ans % MOD;
    }
};
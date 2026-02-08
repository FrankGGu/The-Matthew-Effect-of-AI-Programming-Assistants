#include <vector>
#include <unordered_map>
#include <algorithm> // For std::max

class Solution {
public:
    int lenLongestFibSubsequence(std::vector<int>& arr) {
        int n = arr.size();
        if (n < 3) {
            return 0;
        }

        std::unordered_map<int, int> val_to_idx;
        for (int i = 0; i < n; ++i) {
            val_to_idx[arr[i]] = i;
        }

        // dp[i][j] stores the length of the longest Fibonacci-like subsequence
        // ending with arr[i] and arr[j], where i < j.
        // The length includes arr[i] and arr[j].
        std::vector<std::vector<int>> dp(n, std::vector<int>(n, 0));
        int max_len = 0;

        for (int j = 0; j < n; ++j) {
            for (int i = 0; i < j; ++i) {
                // We are looking for an element arr[k] such that arr[k] + arr[i] = arr[j].
                // Also, arr[k] must be less than arr[i] for the sequence to be strictly increasing.
                int target = arr[j] - arr[i];

                if (target < arr[i] && val_to_idx.count(target)) {
                    int k = val_to_idx[target];

                    // If dp[k][i] is 0, it means arr[k] and arr[i] are the first two elements
                    // of a new Fibonacci-like subsequence. In this case, adding arr[j] makes it length 3.
                    // Otherwise, we extend an existing subsequence.
                    int current_fib_len = (dp[k][i] == 0) ? 3 : dp[k][i] + 1;
                    dp[i][j] = current_fib_len;
                    max_len = std::max(max_len, current_fib_len);
                }
            }
        }

        return max_len;
    }
};
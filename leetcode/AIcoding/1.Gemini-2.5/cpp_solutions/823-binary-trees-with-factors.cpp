#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    int numFactoredBinaryTrees(std::vector<int>& arr) {
        long long MOD = 1000000007;
        int n = arr.size();

        std::sort(arr.begin(), arr.end());

        std::map<int, int> val_to_idx;
        for (int i = 0; i < n; ++i) {
            val_to_idx[arr[i]] = i;
        }

        std::vector<long long> dp(n);
        long long total_trees = 0;

        for (int i = 0; i < n; ++i) {
            dp[i] = 1; // Each number itself forms a single-node tree

            long long root_val = arr[i];

            for (int j = 0; j < i; ++j) {
                long long left_child_val = arr[j];

                if (root_val % left_child_val == 0) {
                    long long right_child_val = root_val / left_child_val;

                    if (val_to_idx.count(right_child_val)) {
                        int k = val_to_idx[right_child_val];
                        dp[i] = (dp[i] + dp[j] * dp[k]) % MOD;
                    }
                }
            }
            total_trees = (total_trees + dp[i]) % MOD;
        }

        return static_cast<int>(total_trees);
    }
};
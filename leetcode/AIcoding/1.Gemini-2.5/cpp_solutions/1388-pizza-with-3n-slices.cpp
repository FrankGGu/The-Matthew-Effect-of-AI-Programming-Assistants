#include <vector>
#include <algorithm>

class Solution {
public:
    int solve(const std::vector<int>& arr, int k) {
        int M = arr.size();
        std::vector<std::vector<int>> dp(M, std::vector<int>(k + 1, -1e9)); 

        dp[0][0] = 0; 
        if (k >= 1) { 
            dp[0][1] = arr[0]; 
        }

        for (int i = 1; i < M; ++i) {
            dp[i][0] = 0; 

            for (int j = 1; j <= k; ++j) {
                dp[i][j] = dp[i-1][j];

                int prev_sum_from_earlier;
                if (i >= 2) {
                    prev_sum_from_earlier = dp[i-2][j-1];
                } else { 
                    prev_sum_from_earlier = (j - 1 == 0) ? 0 : -1e9;
                }

                if (prev_sum_from_earlier != -1e9) {
                    dp[i][j] = std::max(dp[i][j], arr[i] + prev_sum_from_earlier);
                }
            }
        }
        return dp[M-1][k];
    }

    int maxSizeSlices(std::vector<int>& slices) {
        int num_slices_to_pick = slices.size() / 3;

        std::vector<int> slices_without_last(slices.begin(), slices.end() - 1);
        int res1 = solve(slices_without_last, num_slices_to_pick);

        std::vector<int> slices_without_first(slices.begin() + 1, slices.end());
        int res2 = solve(slices_without_first, num_slices_to_pick);

        return std::max(res1, res2);
    }
};
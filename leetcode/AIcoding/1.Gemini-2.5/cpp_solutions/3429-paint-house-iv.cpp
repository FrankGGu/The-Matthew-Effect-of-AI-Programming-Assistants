#include <vector>
#include <algorithm>
#include <climits> // For LLONG_MAX

class Solution {
public:
    int minCost(std::vector<int>& houses, std::vector<std::vector<int>>& cost, int m, int n, int target) {
        long long INF = LLONG_MAX / 2; 

        std::vector<std::vector<std::vector<long long>>> dp(m, 
            std::vector<std::vector<long long>>(n, 
                std::vector<long long>(target + 1, INF)));

        for (int j = 0; j < n; ++j) { 
            if (houses[0] == 0) { 
                dp[0][j][1] = cost[0][j];
            } else if (houses[0] == j + 1) { 
                dp[0][j][1] = 0;
            }
        }

        for (int i = 1; i < m; ++i) {
            for (int k = 1; k <= target; ++k) {
                long long prev_k_minus_1_min1 = INF, prev_k_minus_1_min2 = INF;
                int prev_k_minus_1_color1 = -1, prev_k_minus_1_color2 = -1;
                if (k > 1) { 
                    for (int prev_j = 0; prev_j < n; ++prev_j) {
                        if (dp[i-1][prev_j][k-1] < prev_k_minus_1_min1) {
                            prev_k_minus_1_min2 = prev_k_minus_1_min1;
                            prev_k_minus_1_color2 = prev_k_minus_1_color1;
                            prev_k_minus_1_min1 = dp[i-1][prev_j][k-1];
                            prev_k_minus_1_color1 = prev_j;
                        } else if (dp[i-1][prev_j][k-1] < prev_k_minus_1_min2) {
                            prev_k_minus_1_min2 = dp[i-1][prev_j][k-1];
                            prev_k_minus_1_color2 = prev_j;
                        }
                    }
                }

                for (int j = 0; j < n; ++j) { 
                    if (houses[i] != 0 && houses[i] != j + 1) {
                        continue;
                    }

                    long long current_paint_cost = (houses[i] == 0) ? cost[i][j] : 0;

                    // Case 1: Same color as previous house (j == prev_j)
                    if (dp[i-1][j][k] != INF) {
                        dp[i][j][k] = std::min(dp[i][j][k], dp[i-1][j][k] + current_paint_cost);
                    }

                    // Case 2: Different color from previous house (j != prev_j)
                    if (k > 1) { 
                        if (j != prev_k_minus_1_color1) {
                            if (prev_k_minus_1_min1 != INF) {
                                dp[i][j][k] = std::min(dp[i][j][k], prev_k_minus_1_min1 + current_paint_cost);
                            }
                        } else { 
                            if (prev_k_minus_1_min2 != INF) {
                                dp[i][j][k] = std::min(dp[i][j][k], prev_k_minus_1_min2 + current_paint_cost);
                            }
                        }
                    }
                }
            }
        }

        long long min_total_cost = INF;
        for (int j = 0; j < n; ++j) {
            min_total_cost = std::min(min_total_cost, dp[m-1][j][target]);
        }

        return (min_total_cost == INF) ? -1 : static_cast<int>(min_total_cost);
    }
};
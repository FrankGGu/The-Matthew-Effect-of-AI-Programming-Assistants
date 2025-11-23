#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& houses, vector<vector<int>>& cost, int m, int n, int target) {
        vector<vector<vector<int>>> dp(m + 1, vector<vector<int>>(target + 1, vector<int>(n + 1, -1)));

        function<int(int, int, int)> solve = [&](int house_idx, int neighborhood_count, int prev_color) {
            if (neighborhood_count > target) {
                return -1;
            }

            if (house_idx == m) {
                return neighborhood_count == target ? 0 : -1;
            }

            if (dp[house_idx][neighborhood_count][prev_color] != -1) {
                return dp[house_idx][neighborhood_count][prev_color];
            }

            int min_cost = -1;

            if (houses[house_idx] == 0) {
                for (int color = 1; color <= n; ++color) {
                    int new_neighborhood_count = neighborhood_count + (color != prev_color);
                    int sub_cost = solve(house_idx + 1, new_neighborhood_count, color);
                    if (sub_cost != -1) {
                        int current_cost = cost[house_idx][color - 1] + sub_cost;
                        if (min_cost == -1 || current_cost < min_cost) {
                            min_cost = current_cost;
                        }
                    }
                }
            } else {
                int color = houses[house_idx];
                int new_neighborhood_count = neighborhood_count + (color != prev_color);
                int sub_cost = solve(house_idx + 1, new_neighborhood_count, color);
                if (sub_cost != -1) {
                    min_cost = sub_cost;
                }
            }

            return dp[house_idx][neighborhood_count][prev_color] = min_cost;
        };

        int result = solve(0, 0, 0);
        return result == -1 ? -1 : result;
    }
};
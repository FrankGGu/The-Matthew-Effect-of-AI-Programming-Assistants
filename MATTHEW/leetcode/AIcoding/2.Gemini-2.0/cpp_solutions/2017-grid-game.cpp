#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long gridGame(vector<vector<int>>& grid) {
        int n = grid[0].size();
        vector<long long> prefix_sum_top(n + 1, 0);
        vector<long long> prefix_sum_bottom(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix_sum_top[i + 1] = prefix_sum_top[i] + grid[0][i];
            prefix_sum_bottom[i + 1] = prefix_sum_bottom[i] + grid[1][i];
        }

        long long min_score = -1;

        for (int i = 0; i < n; ++i) {
            long long top_score = prefix_sum_top[n] - prefix_sum_top[i + 1];
            long long bottom_score = prefix_sum_bottom[i];

            long long score = max(top_score, bottom_score);

            if (min_score == -1 || score < min_score) {
                min_score = score;
            }
        }

        return min_score;
    }
};
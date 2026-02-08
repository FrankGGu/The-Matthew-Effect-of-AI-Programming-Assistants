#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxSpending(vector<vector<int>>& costs) {
        int m = costs.size();
        int n = costs[0].size();
        vector<int> indices(m, n - 1);
        long long ans = 0;
        for (int k = 0; k < m * n; ++k) {
            int best_row = -1;
            for (int i = 0; i < m; ++i) {
                if (indices[i] >= 0 && (best_row == -1 || costs[i][indices[i]] > costs[best_row][indices[best_row]])) {
                    best_row = i;
                }
            }
            ans += costs[best_row][indices[best_row]];
            indices[best_row]--;
        }
        return ans;
    }
};
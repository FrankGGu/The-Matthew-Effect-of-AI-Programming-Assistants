#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    double getMinCost(vector<int>& positions, vector<int>& costs) {
        int n = positions.size();
        vector<pair<int, int>> p(n);
        for (int i = 0; i < n; ++i) {
            p[i] = {positions[i], costs[i]};
        }
        sort(p.begin(), p.end());

        vector<double> dp(1 << n, -1.0);

        function<double(int)> solve = [&](int mask) {
            if (mask == (1 << n) - 1) {
                return 0.0;
            }

            if (dp[mask] != -1.0) {
                return dp[mask];
            }

            double ans = 1e18;
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) {
                    ans = min(ans, (double)p[i].second + solve(mask | (1 << i)));
                    for (int j = i + 1; j < n; ++j) {
                        if (!(mask & (1 << j))) {
                            ans = min(ans, abs(p[i].first - p[j].first) * 1.0 * (p[i].second + p[j].second) + solve(mask | (1 << i) | (1 << j)));
                        }
                    }
                    break;
                }
            }
            return dp[mask] = ans;
        };

        return solve(0);
    }
};
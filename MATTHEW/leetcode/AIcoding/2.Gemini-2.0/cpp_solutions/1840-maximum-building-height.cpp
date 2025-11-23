#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxBuilding(int n, vector<vector<int>>& restrictions) {
        restrictions.push_back({1, 0});
        sort(restrictions.begin(), restrictions.end());
        int m = restrictions.size();
        if (restrictions[m - 1][0] != n) {
            restrictions.push_back({n, n});
            m++;
        }

        for (int i = 1; i < m; ++i) {
            restrictions[i][1] = min(restrictions[i][1], restrictions[i - 1][1] + restrictions[i][0] - restrictions[i - 1][0]);
        }

        for (int i = m - 2; i >= 0; --i) {
            restrictions[i][1] = min(restrictions[i][1], restrictions[i + 1][1] + restrictions[i + 1][0] - restrictions[i][0]);
        }

        int ans = 0;
        for (int i = 1; i < m; ++i) {
            int a = restrictions[i - 1][0], b = restrictions[i - 1][1];
            int c = restrictions[i][0], d = restrictions[i][1];
            int dist = c - a;
            int heightDiff = abs(d - b);
            int overlap = max(0, dist - heightDiff);
            ans = max(ans, max(b, d) + overlap / 2);
        }

        return ans;
    }
};
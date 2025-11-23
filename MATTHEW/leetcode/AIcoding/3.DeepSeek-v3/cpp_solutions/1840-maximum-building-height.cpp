#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxBuilding(int n, vector<vector<int>>& restrictions) {
        restrictions.push_back({1, 0});
        sort(restrictions.begin(), restrictions.end());
        if (restrictions.back()[0] != n) {
            restrictions.push_back({n, n - 1});
        }

        int m = restrictions.size();
        for (int i = 1; i < m; ++i) {
            restrictions[i][1] = min(restrictions[i][1], restrictions[i-1][1] + restrictions[i][0] - restrictions[i-1][0]);
        }
        for (int i = m - 2; i >= 0; --i) {
            restrictions[i][1] = min(restrictions[i][1], restrictions[i+1][1] + restrictions[i+1][0] - restrictions[i][0]);
        }

        int res = 0;
        for (int i = 0; i < m - 1; ++i) {
            int left = restrictions[i][0];
            int right = restrictions[i+1][0];
            int h_left = restrictions[i][1];
            int h_right = restrictions[i+1][1];
            int max_h = max(h_left, h_right) + (right - left - abs(h_left - h_right)) / 2;
            res = max(res, max_h);
        }
        return res;
    }
};
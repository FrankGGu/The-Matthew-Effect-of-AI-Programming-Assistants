#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minManhattanDistance(vector<vector<int>>& points) {
        vector<int> x, y;
        for (auto& p : points) {
            x.push_back(p[0]);
            y.push_back(p[1]);
        }
        sort(x.begin(), x.end());
        sort(y.begin(), y.end());
        int n = x.size();
        int min_x = x[(n - 1) / 2];
        int min_y = y[(n - 1) / 2];
        int max_x = x[n / 2];
        int max_y = y[n / 2];
        int res = INT_MAX;
        for (auto& p : points) {
            int px = p[0], py = p[1];
            int dx = max(abs(px - min_x), abs(px - max_x));
            int dy = max(abs(py - min_y), abs(py - max_y));
            res = min(res, dx + dy);
        }
        return res;
    }
};
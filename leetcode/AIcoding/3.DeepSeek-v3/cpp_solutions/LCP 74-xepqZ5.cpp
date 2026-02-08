#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int fieldOfGreatestBlessing(vector<vector<int>>& forceField) {
        vector<long long> x_coords, y_coords;
        for (auto& field : forceField) {
            long long x = field[0], y = field[1], side = field[2];
            long long x1 = 2 * x - side, x2 = 2 * x + side;
            long long y1 = 2 * y - side, y2 = 2 * y + side;
            x_coords.push_back(x1);
            x_coords.push_back(x2);
            y_coords.push_back(y1);
            y_coords.push_back(y2);
        }
        sort(x_coords.begin(), x_coords.end());
        sort(y_coords.begin(), y_coords.end());
        x_coords.erase(unique(x_coords.begin(), x_coords.end()), x_coords.end());
        y_coords.erase(unique(y_coords.begin(), y_coords.end()), y_coords.end());

        int n = x_coords.size(), m = y_coords.size();
        vector<vector<int>> diff(n + 2, vector<int>(m + 2, 0));

        for (auto& field : forceField) {
            long long x = field[0], y = field[1], side = field[2];
            long long x1 = 2 * x - side, x2 = 2 * x + side;
            long long y1 = 2 * y - side, y2 = 2 * y + side;
            int lx = lower_bound(x_coords.begin(), x_coords.end(), x1) - x_coords.begin() + 1;
            int rx = lower_bound(x_coords.begin(), x_coords.end(), x2) - x_coords.begin() + 1;
            int ly = lower_bound(y_coords.begin(), y_coords.end(), y1) - y_coords.begin() + 1;
            int ry = lower_bound(y_coords.begin(), y_coords.end(), y2) - y_coords.begin() + 1;
            diff[lx][ly]++;
            diff[lx][ry + 1]--;
            diff[rx + 1][ly]--;
            diff[rx + 1][ry + 1]++;
        }

        int max_count = 0;
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                diff[i][j] += diff[i - 1][j] + diff[i][j - 1] - diff[i - 1][j - 1];
                max_count = max(max_count, diff[i][j]);
            }
        }
        return max_count;
    }
};
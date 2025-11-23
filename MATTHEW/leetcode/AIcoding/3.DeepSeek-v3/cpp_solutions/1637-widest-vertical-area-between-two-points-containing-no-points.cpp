#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxWidthOfVerticalArea(vector<vector<int>>& points) {
        sort(points.begin(), points.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        int max_width = 0;
        for (int i = 1; i < points.size(); ++i) {
            max_width = max(max_width, points[i][0] - points[i-1][0]);
        }
        return max_width;
    }
};
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxWidthOfVerticalArea(vector<vector<int>>& points) {
        vector<int> x_coords;
        for (const auto& point : points) {
            x_coords.push_back(point[0]);
        }
        sort(x_coords.begin(), x_coords.end());

        int max_width = 0;
        for (size_t i = 1; i < x_coords.size(); ++i) {
            max_width = max(max_width, x_coords[i] - x_coords[i - 1]);
        }

        return max_width;
    }
};
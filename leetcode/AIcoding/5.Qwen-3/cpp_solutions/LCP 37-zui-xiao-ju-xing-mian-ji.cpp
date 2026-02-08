#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int minArea(vector<vector<int>>& points) {
        int min_x = INT_MAX;
        int max_x = INT_MIN;
        int min_y = INT_MAX;
        int max_y = INT_MIN;

        for (const auto& p : points) {
            min_x = min(min_x, p[0]);
            max_x = max(max_x, p[0]);
            min_y = min(min_y, p[1]);
            max_y = max(max_y, p[1]);
        }

        return (max_x - min_x) * (max_y - min_y);
    }
};
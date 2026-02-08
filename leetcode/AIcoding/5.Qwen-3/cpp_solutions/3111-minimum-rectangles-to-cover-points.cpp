#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minRectanglesToCoverPoints(vector<vector<int>>& points, int w) {
        sort(points.begin(), points.end());
        int count = 0;
        int i = 0;
        while (i < points.size()) {
            int x = points[i][0];
            count++;
            while (i < points.size() && points[i][0] <= x + w) {
                i++;
            }
        }
        return count;
    }
};
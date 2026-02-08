#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minRectanglesToCoverPoints(vector<vector<int>>& points, int w) {
        sort(points.begin(), points.end());
        int res = 0;
        int n = points.size();
        int i = 0;
        while (i < n) {
            int start = points[i][0];
            int end = start + w;
            res++;
            while (i < n && points[i][0] <= end) {
                i++;
            }
        }
        return res;
    }
};
#include <vector>
using namespace std;

class Solution {
public:
    int countDays(vector<vector<int>>& points) {
        int n = points.size();
        if (n < 3) return 0;

        int count = 0;
        for (int i = 2; i < n; i++) {
            if (points[i-2][0] < points[i-1][0] && points[i-2][1] < points[i-1][1] &&
                points[i-1][0] < points[i][0] && points[i-1][1] < points[i][1]) {
                count++;
            }
        }
        return count;
    }
};
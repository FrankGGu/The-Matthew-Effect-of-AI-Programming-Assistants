#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int intersectionSizeTwo(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            if (a[1] != b[1]) {
                return a[1] < b[1];
            }
            return a[0] > b[0];
        });

        int n = intervals.size();
        int ans = 0;
        int a = -1, b = -1;

        for (int i = 0; i < n; ++i) {
            int start = intervals[i][0];
            int end = intervals[i][1];

            if (a >= start && b >= start) {
                continue;
            } else if (b >= start) {
                ans++;
                a = b;
                b = end;
            } else {
                ans += 2;
                b = end;
                a = end - 1;
            }
        }

        return ans;
    }
};
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxNonOverlapping(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int count = 0;
        int end = -1;

        for (const auto& interval : intervals) {
            if (interval[0] >= end) {
                count++;
                end = interval[1];
            }
        }

        return count;
    }
};
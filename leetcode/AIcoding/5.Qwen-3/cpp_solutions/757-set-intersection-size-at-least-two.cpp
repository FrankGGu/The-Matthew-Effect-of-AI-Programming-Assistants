#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int intersectionSizeFirstTwo(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int res = 0;
        int last = -1, secondLast = -1;

        for (const auto& interval : intervals) {
            int start = interval[0], end = interval[1];
            if (start > secondLast) {
                res += 2;
                secondLast = end;
                last = end;
            } else if (start > last) {
                res += 1;
                secondLast = last;
                last = end;
            }
        }

        return res;
    }
};
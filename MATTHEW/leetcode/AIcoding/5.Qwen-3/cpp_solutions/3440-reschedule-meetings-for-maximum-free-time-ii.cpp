#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getFreeTime(vector<vector<int>>& intervals) {
        if (intervals.empty()) return {};

        sort(intervals.begin(), intervals.end());

        vector<int> result;
        int prevEnd = intervals[0][1];

        for (int i = 1; i < intervals.size(); ++i) {
            int start = intervals[i][0];
            if (start > prevEnd) {
                result.push_back(prevEnd);
                result.push_back(start);
            }
            prevEnd = max(prevEnd, intervals[i][1]);
        }

        return result;
    }
};
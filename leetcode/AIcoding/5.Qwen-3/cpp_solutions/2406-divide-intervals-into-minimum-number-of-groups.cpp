#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int mergeIntervals(vector<vector<int>>& intervals) {
        if (intervals.empty()) return 0;

        sort(intervals.begin(), intervals.end());

        int groups = 1;
        priority_queue<int, vector<int>, greater<int>> endTimes;
        endTimes.push(intervals[0][1]);

        for (int i = 1; i < intervals.size(); ++i) {
            if (intervals[i][0] > endTimes.top()) {
                endTimes.pop();
            }
            endTimes.push(intervals[i][1]);
        }

        return endTimes.size();
    }
};
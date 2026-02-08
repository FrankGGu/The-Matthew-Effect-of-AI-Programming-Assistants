#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxFreeTime(vector<vector<int>>& meetings) {
        vector<pair<int, int>> intervals;
        for (auto& meeting : meetings) {
            intervals.push_back({meeting[0], meeting[1]});
        }

        sort(intervals.begin(), intervals.end());

        int max_free_time = 0;
        int end = intervals[0].second;
        for (int i = 1; i < intervals.size(); ++i) {
            if (intervals[i].first > end) {
                max_free_time = max(max_free_time, intervals[i].first - end);
            }
            end = max(end, intervals[i].second);
        }

        return max_free_time;
    }
};
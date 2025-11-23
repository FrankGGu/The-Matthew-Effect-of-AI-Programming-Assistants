#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    vector<int> maxFreeTime(vector<vector<int>>& meetings) {
        vector<pair<int, int>> intervals;
        for (const auto& meeting : meetings) {
            intervals.emplace_back(meeting[0], meeting[1]);
        }
        sort(intervals.begin(), intervals.end());

        vector<int> freeTime;
        int end = intervals[0].second;

        for (int i = 1; i < intervals.size(); ++i) {
            if (intervals[i].first > end) {
                freeTime.push_back(end);
                freeTime.push_back(intervals[i].first);
            }
            end = max(end, intervals[i].second);
        }

        return freeTime;
    }
};
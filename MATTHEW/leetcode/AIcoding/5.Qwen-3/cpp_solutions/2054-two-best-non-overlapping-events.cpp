#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxTwoEvents(vector<vector<int>>& events) {
        vector<pair<int, int>> sortedEvents;
        for (const auto& event : events) {
            sortedEvents.emplace_back(event[0], event[1]);
        }
        sort(sortedEvents.begin(), sortedEvents.end());

        vector<int> endTimes;
        for (const auto& e : sortedEvents) {
            endTimes.push_back(e.second);
        }

        int n = events.size();
        vector<int> maxEventValue(n, 0);
        int maxVal = 0;
        for (int i = n - 1; i >= 0; --i) {
            maxVal = max(maxVal, sortedEvents[i].second);
            maxEventValue[i] = maxVal;
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            int startTime = sortedEvents[i].first;
            int endTime = sortedEvents[i].second;
            int idx = upper_bound(endTimes.begin(), endTimes.end(), startTime) - endTimes.begin();
            if (idx < n) {
                result = max(result, endTime + maxEventValue[idx]);
            } else {
                result = max(result, endTime);
            }
        }

        return result;
    }
};
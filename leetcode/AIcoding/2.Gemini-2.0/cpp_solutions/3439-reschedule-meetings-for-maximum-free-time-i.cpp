#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxFreeTime(vector<vector<int>>& meetings) {
        vector<pair<int, int>> events;
        for (auto& meeting : meetings) {
            events.push_back({meeting[0], 1});
            events.push_back({meeting[1], -1});
        }

        sort(events.begin(), events.end());

        int maxFree = 0;
        int currentMeetings = 0;
        int prevTime = 0;

        for (int i = 0; i < events.size(); ++i) {
            if (currentMeetings == 0 && i > 0) {
                maxFree = max(maxFree, events[i].first - prevTime);
            }

            currentMeetings += events[i].second;
            prevTime = events[i].first;
        }

        return maxFree;
    }
};
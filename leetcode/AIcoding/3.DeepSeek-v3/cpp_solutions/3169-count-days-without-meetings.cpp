#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countDays(int days, vector<vector<int>>& meetings) {
        if (meetings.empty()) return days;

        sort(meetings.begin(), meetings.end());

        vector<vector<int>> merged;
        merged.push_back(meetings[0]);

        for (int i = 1; i < meetings.size(); ++i) {
            auto& last = merged.back();
            if (meetings[i][0] <= last[1]) {
                last[1] = max(last[1], meetings[i][1]);
            } else {
                merged.push_back(meetings[i]);
            }
        }

        int meetingDays = 0;
        for (auto& interval : merged) {
            meetingDays += interval[1] - interval[0] + 1;
        }

        return days - meetingDays;
    }
};
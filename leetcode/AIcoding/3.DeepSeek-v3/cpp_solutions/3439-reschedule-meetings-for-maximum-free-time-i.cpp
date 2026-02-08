#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxFreeTime(vector<vector<int>>& schedule) {
        sort(schedule.begin(), schedule.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        int maxGap = 0;
        int end = schedule[0][1];

        for (int i = 1; i < schedule.size(); ++i) {
            if (schedule[i][0] > end) {
                maxGap = max(maxGap, schedule[i][0] - end);
            }
            end = max(end, schedule[i][1]);
        }

        return maxGap;
    }
};
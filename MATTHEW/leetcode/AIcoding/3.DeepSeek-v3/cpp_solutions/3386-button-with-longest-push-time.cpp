#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestPushTime(vector<vector<int>>& buttons) {
        if (buttons.empty()) return 0;
        sort(buttons.begin(), buttons.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        int maxTime = buttons[0][1];
        int currentEnd = buttons[0][1];

        for (int i = 1; i < buttons.size(); ++i) {
            if (buttons[i][0] <= currentEnd) {
                currentEnd = max(currentEnd, buttons[i][1]);
            } else {
                currentEnd = buttons[i][1];
            }
            maxTime = max(maxTime, currentEnd - buttons[i][0]);
        }

        return maxTime;
    }
};
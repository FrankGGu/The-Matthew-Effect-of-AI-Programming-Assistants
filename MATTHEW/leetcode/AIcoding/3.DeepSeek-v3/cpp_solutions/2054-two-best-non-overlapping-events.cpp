#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxTwoEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end());
        int n = events.size();
        vector<int> dp(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            dp[i] = max(dp[i + 1], events[i][2]);
        }
        int res = 0;
        for (int i = 0; i < n; ++i) {
            int left = i + 1, right = n;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (events[mid][0] > events[i][1]) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            res = max(res, events[i][2] + dp[left]);
        }
        return res;
    }
};
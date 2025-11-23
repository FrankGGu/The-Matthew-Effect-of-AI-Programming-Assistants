#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValue(vector<vector<int>>& events, int k) {
        sort(events.begin(), events.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int n = events.size();
        vector<vector<int>> dp(k + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= k; ++i) {
            for (int j = 1; j <= n; ++j) {
                int current_value = events[j - 1][2];
                int end_time = events[j - 1][1];
                int prev_index = -1;

                int low = 0, high = j - 1;
                while (low < high) {
                    int mid = low + (high - low) / 2;
                    if (events[mid][1] < events[j - 1][0]) {
                        low = mid + 1;
                    } else {
                        high = mid;
                    }
                }

                if (low > 0 && events[low -1][1] < events[j - 1][0]) {
                  prev_index = low -1;
                } else if (low == 0 && events[0][1] >= events[j-1][0]) {
                   prev_index = -1;
                } else if (low > 0 && events[low-1][1] >= events[j-1][0]){
                    prev_index = low-1;
                   while (prev_index >=0 && events[prev_index][1] >= events[j-1][0]) {
                       prev_index--;
                   }
                }

                dp[i][j] = dp[i][j - 1];
                if (prev_index == -1) {
                    dp[i][j] = max(dp[i][j], current_value);
                } else {
                    dp[i][j] = max(dp[i][j], dp[i - 1][prev_index + 1] + current_value);
                }
            }
        }

        return dp[k][n];
    }
};
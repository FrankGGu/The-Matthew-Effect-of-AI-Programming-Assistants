#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTwoEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end());
        int n = events.size();
        vector<int> max_val(n);
        max_val[n - 1] = events[n - 1][2];
        for (int i = n - 2; i >= 0; --i) {
            max_val[i] = max(max_val[i + 1], events[i][2]);
        }
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            int current_val = events[i][2];
            int end_time = events[i][1];
            int low = i + 1, high = n - 1, next_event_index = n;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (events[mid][0] > end_time) {
                    next_event_index = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            if (next_event_index < n) {
                ans = max(ans, current_val + max_val[next_event_index]);
            } else {
                ans = max(ans, current_val);
            }
        }
        return ans;
    }
};
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTwoEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end());
        int n = events.size();
        vector<int> suffixMax(n);
        suffixMax[n - 1] = events[n - 1][2];
        for (int i = n - 2; i >= 0; --i) {
            suffixMax[i] = max(suffixMax[i + 1], events[i][2]);
        }

        int ans = 0;
        for (int i = 0; i < n; ++i) {
            int currentVal = events[i][2];
            int nextEventIndex = upper_bound(events.begin() + i + 1, events.end(), vector<int>{events[i][1], INT_MAX, INT_MAX}) - events.begin();
            if (nextEventIndex < n) {
                ans = max(ans, currentVal + suffixMax[nextEventIndex]);
            } else {
                ans = max(ans, currentVal);
            }
        }
        if(n >= 1)
          ans = max(ans, suffixMax[0]);
        return ans;
    }
};
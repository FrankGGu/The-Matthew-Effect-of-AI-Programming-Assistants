#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        vector<int> dp;
        for (const auto& event : events) {
            int start = event[0], end = event[1];
            auto it = lower_bound(dp.begin(), dp.end(), start);
            if (it != dp.end()) {
                *it = end;
            } else {
                dp.push_back(end);
            }
        }

        return dp.size();
    }
};
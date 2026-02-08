#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxEnvelopes(vector<vector<int>>& envelopes) {
        if (envelopes.empty()) return 0;

        sort(envelopes.begin(), envelopes.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] == b[0] ? a[1] > b[1] : a[0] < b[0];
        });

        vector<int> dp;
        for (const auto& env : envelopes) {
            int height = env[1];
            auto it = lower_bound(dp.begin(), dp.end(), height);
            if (it == dp.end()) {
                dp.push_back(height);
            } else {
                *it = height;
            }
        }

        return dp.size();
    }
};
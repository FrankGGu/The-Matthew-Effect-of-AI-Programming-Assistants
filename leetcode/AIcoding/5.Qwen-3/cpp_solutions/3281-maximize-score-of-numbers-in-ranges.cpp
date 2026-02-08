#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums, vector<int>& ranges) {
        int n = nums.size();
        vector<pair<int, int>> intervals;
        for (int i = 0; i < n; ++i) {
            intervals.push_back({ranges[i], i});
        }
        sort(intervals.begin(), intervals.end());

        vector<int> used(n, 0);
        long long score = 0;

        for (int i = 0; i < n; ++i) {
            int l = intervals[i].first;
            int idx = intervals[i].second;
            if (used[idx] == 0) {
                score += nums[idx];
                for (int j = 0; j < n; ++j) {
                    if (ranges[j] >= l && used[j] == 0) {
                        used[j] = 1;
                    }
                }
            }
        }

        return score;
    }
};
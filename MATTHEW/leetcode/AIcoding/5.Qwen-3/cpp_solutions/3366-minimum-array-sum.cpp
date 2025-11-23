#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minArraySum(vector<int>& nums, vector<int>& l, vector<int>& r, int k) {
        int n = nums.size();
        vector<pair<int, int>> intervals;
        for (int i = 0; i < n; ++i) {
            intervals.push_back({l[i], r[i]});
        }
        sort(intervals.begin(), intervals.end());

        vector<long long> ops(n, 0);
        for (int i = 0; i < n; ++i) {
            int left = intervals[i].first;
            int right = intervals[i].second;
            ops[i] = right - left + 1;
        }

        long long total = 0;
        for (int i = 0; i < n; ++i) {
            total += nums[i];
        }

        long long remaining = k;
        for (int i = 0; i < n && remaining > 0; ++i) {
            int cnt = ops[i];
            if (cnt <= 0) continue;
            long long add = min(remaining, static_cast<long long>(cnt));
            total -= add;
            remaining -= add;
        }

        return total;
    }
};
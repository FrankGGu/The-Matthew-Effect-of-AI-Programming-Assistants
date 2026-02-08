#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minAbsoluteDifference(vector<int>& nums, int x) {
        int n = nums.size();
        vector<int> sorted;
        int minDiff = INT_MAX;

        for (int i = 0; i < n; ++i) {
            int target = nums[i] - x;
            auto it = lower_bound(sorted.begin(), sorted.end(), target);
            if (it != sorted.end()) {
                minDiff = min(minDiff, abs(*it - nums[i]));
            }
            if (it != sorted.begin()) {
                minDiff = min(minDiff, abs(*prev(it) - nums[i]));
            }
            sorted.insert(it, nums[i]);
        }

        return minDiff;
    }
};
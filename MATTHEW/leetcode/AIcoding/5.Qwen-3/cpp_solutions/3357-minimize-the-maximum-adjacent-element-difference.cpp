#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimizeMaxDifference(vector<int>& nums, int k) {
        int n = nums.size();
        if (n <= 1 || k == 0) return 0;

        vector<int> diff(n - 1);
        for (int i = 0; i < n - 1; ++i) {
            diff[i] = abs(nums[i] - nums[i + 1]);
        }

        sort(diff.begin(), diff.end());

        for (int i = 0; i < k; ++i) {
            if (diff[i] == 0) continue;
            diff[i]--;
        }

        return *max_element(diff.begin(), diff.end());
    }
};
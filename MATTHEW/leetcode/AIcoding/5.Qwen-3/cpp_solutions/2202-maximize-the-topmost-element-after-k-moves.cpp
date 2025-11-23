#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumTop(vector<int>& nums, int k) {
        int n = nums.size();
        if (k == 0) {
            return nums[0];
        }
        if (n == 1) {
            return k % 2 == 0 ? nums[0] : -1;
        }
        if (k >= n) {
            return *max_element(nums.begin(), nums.end());
        }
        int max_val = -1;
        for (int i = 0; i < k; ++i) {
            max_val = max(max_val, nums[i]);
        }
        if (k < n) {
            max_val = max(max_val, nums[k]);
        }
        return max_val;
    }
};
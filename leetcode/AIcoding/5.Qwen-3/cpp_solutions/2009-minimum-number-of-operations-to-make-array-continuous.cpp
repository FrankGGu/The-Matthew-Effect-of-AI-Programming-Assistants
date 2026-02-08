#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        int res = n;
        for (int i = 0; i < n; ++i) {
            int target = nums[i] + n - 1;
            int j = i;
            while (j < n && nums[j] <= target) {
                ++j;
            }
            res = min(res, n - (j - i));
        }
        return res;
    }
};
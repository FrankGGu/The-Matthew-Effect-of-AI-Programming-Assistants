#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minIncrements(vector<int>& nums, int k) {
        int res = 0;
        sort(nums.begin(), nums.end());
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] < nums[i - 1] + k) {
                res += (nums[i - 1] + k) - nums[i];
                nums[i] = nums[i - 1] + k;
            }
        }
        return res;
    }
};
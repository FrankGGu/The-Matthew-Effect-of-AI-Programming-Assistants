#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxStrength(vector<int>& nums) {
        int n = nums.size();
        if (n == 1) return nums[0];

        sort(nums.begin(), nums.end());

        int product1 = nums[n-1] * nums[n-2] * nums[n-3];
        int product2 = nums[0] * nums[1] * nums[n-1];

        return max(product1, product2);
    }
};
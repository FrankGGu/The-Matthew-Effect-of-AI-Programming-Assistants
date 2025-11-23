#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    double findNonMinOrMax(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        if (n < 3) return -1.0;
        return (nums[0] + nums[n - 1]) / 2.0;
    }
};
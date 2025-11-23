#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumSum(int n, vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int maxSum = 0;
        for (int i = 0; i < n - 1; i += 2) {
            maxSum += nums[i] + nums[i + 1];
        }
        return maxSum;
    }
};
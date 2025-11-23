#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minPairSum(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int maxPair = 0;
        for (int i = 0; i < n / 2; ++i) {
            maxPair = max(maxPair, nums[i] + nums[n - 1 - i]);
        }
        return maxPair;
    }
};
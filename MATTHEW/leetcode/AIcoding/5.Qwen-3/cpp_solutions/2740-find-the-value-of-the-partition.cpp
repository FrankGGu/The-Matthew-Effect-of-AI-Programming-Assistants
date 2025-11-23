#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findValueOfPartition(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int minDiff = INT_MAX;
        for (int i = 1; i < nums.size(); ++i) {
            minDiff = min(minDiff, nums[i] - nums[i - 1]);
        }
        return minDiff;
    }
};
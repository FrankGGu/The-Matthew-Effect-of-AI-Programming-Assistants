#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSubarrayLen(int target, vector<int>& nums) {
        int n = nums.size();
        int left = 0;
        int currentSum = 0;
        int minLength = n + 1;

        for (int right = 0; right < n; ++right) {
            currentSum += nums[right];
            while (currentSum >= target) {
                minLength = min(minLength, right - left + 1);
                currentSum -= nums[left];
                ++left;
            }
        }

        return minLength == n + 1 ? 0 : minLength;
    }
};
#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int n = nums.size();
        int total = 0;
        for (int num : nums) {
            total += num;
        }
        int target = total - x;
        if (target < 0) return -1;
        int maxLen = -1;
        int currentSum = 0;
        int left = 0;
        for (int right = 0; right < n; ++right) {
            currentSum += nums[right];
            while (currentSum > target && left <= right) {
                currentSum -= nums[left++];
            }
            if (currentSum == target) {
                maxLen = max(maxLen, right - left + 1);
            }
        }
        return (maxLen == -1) ? -1 : n - maxLen;
    }
};
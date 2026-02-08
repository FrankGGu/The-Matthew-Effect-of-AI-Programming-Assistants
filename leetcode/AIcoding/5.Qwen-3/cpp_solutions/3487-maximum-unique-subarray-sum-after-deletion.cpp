#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumUniqueSubarray(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> lastOccurrence;
        int left = 0;
        int maxSum = 0;
        int currentSum = 0;

        for (int right = 0; right < n; ++right) {
            if (lastOccurrence.find(nums[right]) != lastOccurrence.end() && lastOccurrence[nums[right]] >= left) {
                while (left <= lastOccurrence[nums[right]]) {
                    currentSum -= nums[left];
                    ++left;
                }
            }
            currentSum += nums[right];
            lastOccurrence[nums[right]] = right;
            maxSum = max(maxSum, currentSum);
        }

        return maxSum;
    }
};
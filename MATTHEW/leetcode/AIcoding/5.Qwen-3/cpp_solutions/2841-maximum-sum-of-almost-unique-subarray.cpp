#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxSum(vector<int>& nums, int k) {
        int n = nums.size();
        int left = 0;
        int maxSum = 0;
        int currentSum = 0;
        unordered_map<int, int> freq;

        for (int right = 0; right < n; ++right) {
            currentSum += nums[right];
            freq[nums[right]]++;

            while (freq[nums[right]] > 1) {
                currentSum -= nums[left];
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    freq.erase(nums[left]);
                }
                left++;
            }

            maxSum = max(maxSum, currentSum);
        }

        return maxSum;
    }
};
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    long long maximumSubarraySum(std::vector<int>& nums, int k) {
        long long maxSum = 0;
        long long currentSum = 0;
        std::unordered_map<int, int> freq;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            currentSum += nums[right];
            freq[nums[right]]++;

            if (right - left + 1 > k) {
                currentSum -= nums[left];
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    freq.erase(nums[left]);
                }
                left++;
            }

            if (right - left + 1 == k) {
                if (freq.size() == k) {
                    maxSum = std::max(maxSum, currentSum);
                }
            }
        }

        return maxSum;
    }
};
#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long maximumSubarraySum(vector<int>& nums, int k) {
        long long maxSum = 0;
        long long currentSum = 0;
        unordered_map<int, int> freq;
        for (int i = 0; i < k; ++i) {
            currentSum += nums[i];
            freq[nums[i]]++;
        }
        if (freq.size() == k) {
            maxSum = currentSum;
        }
        for (int i = k; i < nums.size(); ++i) {
            int out = nums[i - k];
            int in = nums[i];
            currentSum -= out;
            currentSum += in;
            freq[out]--;
            if (freq[out] == 0) {
                freq.erase(out);
            }
            freq[in]++;
            if (freq.size() == k) {
                maxSum = max(maxSum, currentSum);
            }
        }
        return maxSum;
    }
};
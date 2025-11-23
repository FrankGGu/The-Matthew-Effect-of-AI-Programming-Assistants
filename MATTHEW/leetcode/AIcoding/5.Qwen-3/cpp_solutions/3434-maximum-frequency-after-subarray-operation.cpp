#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxFrequency(vector<int>& nums, int k) {
        int n = nums.size();
        int left = 0;
        long long sum = 0;
        int maxFreq = 0;

        for (int right = 0; right < n; ++right) {
            sum += nums[right];

            while (sum - nums[right] * (right - left + 1) > k) {
                sum -= nums[left];
                left++;
            }

            maxFreq = max(maxFreq, right - left + 1);
        }

        return maxFreq;
    }
};
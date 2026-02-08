#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int total = 0;
        for (int num : nums) {
            total += num;
        }

        int target = total - x;
        if (target < 0) return -1;

        unordered_map<int, int> prefixSum;
        prefixSum[0] = -1;
        int maxLen = -1;
        int currentSum = 0;

        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (prefixSum.find(currentSum) == prefixSum.end()) {
                prefixSum[currentSum] = i;
            }
            if (prefixSum.find(currentSum - target) != prefixSum.end()) {
                int prevIndex = prefixSum[currentSum - target];
                maxLen = max(maxLen, i - prevIndex);
            }
        }

        if (maxLen == -1) return -1;
        return nums.size() - maxLen;
    }
};
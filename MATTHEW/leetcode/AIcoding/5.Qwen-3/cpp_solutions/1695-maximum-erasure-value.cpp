#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maximumErasureValue(vector<int>& nums) {
        int left = 0;
        int maxSum = 0;
        int currentSum = 0;
        unordered_set<int> seen;

        for (int right = 0; right < nums.size(); ++right) {
            while (seen.find(nums[right]) != seen.end()) {
                seen.erase(nums[left]);
                currentSum -= nums[left];
                ++left;
            }
            seen.insert(nums[right]);
            currentSum += nums[right];
            maxSum = max(maxSum, currentSum);
        }

        return maxSum;
    }
};
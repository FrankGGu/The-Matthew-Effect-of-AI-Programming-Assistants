#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumSubarraySum(vector<int>& nums) {
        int n = nums.size();
        int maxSum = INT_MIN;
        int currentSum = 0;
        int removeIndex = -1;

        for (int i = 0; i < n; ++i) {
            if (removeIndex != -1 && i == removeIndex) {
                continue;
            }
            currentSum += nums[i];
            maxSum = max(maxSum, currentSum);
            if (currentSum < 0) {
                currentSum = 0;
                removeIndex = -1;
            } else {
                removeIndex = i;
            }
        }

        return maxSum;
    }
};
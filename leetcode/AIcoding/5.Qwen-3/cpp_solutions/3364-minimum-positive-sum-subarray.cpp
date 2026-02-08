#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minPositiveSumSubarray(vector<int>& nums) {
        int n = nums.size();
        int minSum = INT_MAX;
        int currentSum = 0;

        for (int i = 0; i < n; ++i) {
            currentSum += nums[i];
            if (currentSum > 0) {
                minSum = min(minSum, currentSum);
            } else {
                currentSum = 0;
            }
        }

        return minSum;
    }
};
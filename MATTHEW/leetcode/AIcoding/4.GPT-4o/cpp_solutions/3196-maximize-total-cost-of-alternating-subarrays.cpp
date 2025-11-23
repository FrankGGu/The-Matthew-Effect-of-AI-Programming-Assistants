class Solution {
public:
    long long maxAlternatingSum(vector<int>& nums) {
        long long evenSum = 0, oddSum = 0, maxSum = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                evenSum += nums[i];
            } else {
                oddSum += nums[i];
            }
            maxSum = max(maxSum, evenSum - oddSum);
            if (i % 2 == 1) {
                evenSum = oddSum = 0;
            }
        }
        return maxSum;
    }
};
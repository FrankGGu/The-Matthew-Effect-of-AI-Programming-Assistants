class Solution {
public:
    long long maxAlternatingSum(vector<int>& nums) {
        long long evenSum = 0, oddSum = 0;
        for (int num : nums) {
            evenSum = max(evenSum, oddSum + num);
            oddSum = max(oddSum, evenSum - num);
        }
        return evenSum;
    }
};
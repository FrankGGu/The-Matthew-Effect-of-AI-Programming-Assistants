class Solution {
public:
    int maxAlternatingSum(vector<int>& nums) {
        int evenSum = 0, oddSum = 0;
        for (int num : nums) {
            evenSum = max(evenSum, oddSum + num);
            oddSum = max(oddSum, evenSum - num);
        }
        return evenSum;
    }
};
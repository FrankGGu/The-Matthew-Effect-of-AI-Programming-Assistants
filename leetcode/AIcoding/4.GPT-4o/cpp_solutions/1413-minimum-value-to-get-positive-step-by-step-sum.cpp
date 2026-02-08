class Solution {
public:
    int minStartValue(vector<int>& nums) {
        int minSum = 0, currentSum = 0;
        for (int num : nums) {
            currentSum += num;
            minSum = min(minSum, currentSum);
        }
        return 1 - minSum;
    }
};
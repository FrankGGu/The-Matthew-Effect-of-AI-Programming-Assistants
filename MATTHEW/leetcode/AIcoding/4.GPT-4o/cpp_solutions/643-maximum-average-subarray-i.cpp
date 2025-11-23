class Solution {
public:
    double findMaxAverage(vector<int>& nums, int k) {
        double maxAvg = INT_MIN;
        double currentSum = 0;

        for (int i = 0; i < k; i++) {
            currentSum += nums[i];
        }

        maxAvg = currentSum / k;

        for (int i = k; i < nums.size(); i++) {
            currentSum += nums[i] - nums[i - k];
            maxAvg = max(maxAvg, currentSum / k);
        }

        return maxAvg;
    }
};
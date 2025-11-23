public class Solution {
    public double findMaxAverage(int[] nums, int k) {
        double maxAvg = 0;
        double currentSum = 0;

        for (int i = 0; i < k; i++) {
            currentSum += nums[i];
        }

        maxAvg = currentSum / k;

        for (int i = k; i < nums.length; i++) {
            currentSum += nums[i] - nums[i - k];
            if (currentSum / k > maxAvg) {
                maxAvg = currentSum / k;
            }
        }

        return maxAvg;
    }
}
import java.util.Arrays;

class Solution {
    public double minimumAverage(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        double minAvg = Double.MAX_VALUE;

        for (int i = 0; i < n / 2; i++) {
            double currentAvg = (nums[i] + nums[n - 1 - i]) / 2.0;
            if (currentAvg < minAvg) {
                minAvg = currentAvg;
            }
        }
        return minAvg;
    }
}
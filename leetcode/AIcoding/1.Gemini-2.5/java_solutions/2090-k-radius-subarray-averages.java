import java.util.Arrays;

class Solution {
    public int[] getAverages(int[] nums, int k) {
        int n = nums.length;
        int[] averages = new int[n];
        Arrays.fill(averages, -1);

        long currentWindowSum = 0;
        int windowSize = 2 * k + 1;

        if (windowSize > n) {
            return averages;
        }

        for (int i = 0; i < n; i++) {
            currentWindowSum += nums[i];

            if (i >= windowSize - 1) {
                int centerIndex = i - k;
                averages[centerIndex] = (int)(currentWindowSum / windowSize);
                currentWindowSum -= nums[i - (windowSize - 1)];
            }
        }

        return averages;
    }
}
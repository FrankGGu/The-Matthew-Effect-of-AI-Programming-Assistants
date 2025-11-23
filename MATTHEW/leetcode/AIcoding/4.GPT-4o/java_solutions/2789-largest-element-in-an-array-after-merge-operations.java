import java.util.Arrays;

public class Solution {
    public int maxArrayValue(int[] nums) {
        long maxValue = 0;
        long currentSum = 0;

        for (int i = nums.length - 1; i >= 0; i--) {
            currentSum += nums[i];
            maxValue = Math.max(maxValue, currentSum);
        }

        return (int) maxValue;
    }
}
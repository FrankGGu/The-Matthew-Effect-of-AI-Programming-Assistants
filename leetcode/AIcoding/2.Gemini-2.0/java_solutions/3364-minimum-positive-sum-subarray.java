import java.util.Arrays;

class Solution {

    public int minSubarray(int[] nums) {
        int n = nums.length;
        int minLen = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n; j++) {
                sum += nums[j];
                if (sum > 0) {
                    minLen = Math.min(minLen, j - i + 1);
                    break;
                }
            }
        }
        return minLen == Integer.MAX_VALUE ? -1 : minLen;
    }
}
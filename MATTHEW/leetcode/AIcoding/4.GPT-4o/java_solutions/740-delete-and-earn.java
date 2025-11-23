public class Solution {
    public int deleteAndEarn(int[] nums) {
        int max = 0;
        for (int num : nums) {
            max = Math.max(max, num);
        }

        int[] dp = new int[max + 1];
        for (int num : nums) {
            dp[num] += num;
        }

        int[] earn = new int[max + 1];
        earn[0] = 0;
        earn[1] = dp[1];

        for (int i = 2; i <= max; i++) {
            earn[i] = Math.max(earn[i - 1], earn[i - 2] + dp[i]);
        }

        return earn[max];
    }
}
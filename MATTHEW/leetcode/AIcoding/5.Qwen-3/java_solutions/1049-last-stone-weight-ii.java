public class Solution {

import java.util.Arrays;

public class Solution {
    public int lastStoneWeightII(int[] stones) {
        int sum = Arrays.stream(stones).sum();
        boolean[] dp = new boolean[sum + 1];
        dp[0] = true;
        for (int stone : stones) {
            for (int i = sum; i >= stone; i--) {
                if (dp[i - stone]) {
                    dp[i] = true;
                }
            }
        }
        for (int i = sum; i >= 0; i--) {
            if (dp[i]) {
                return sum - 2 * i;
            }
        }
        return 0;
    }
}
}
public class Solution {

import java.util.*;

public class Solution {
    public int minSessions(int[] tasks) {
        Arrays.sort(tasks);
        int n = tasks.length;
        int total = 0;
        for (int task : tasks) {
            total += task;
        }
        int[] dp = new int[total + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;
        for (int task : tasks) {
            for (int i = total; i >= task; i--) {
                if (dp[i - task] != Integer.MAX_VALUE) {
                    dp[i] = Math.min(dp[i], dp[i - task] + 1);
                }
            }
        }
        for (int i = total; i >= 0; i--) {
            if (dp[i] != Integer.MAX_VALUE) {
                return dp[i];
            }
        }
        return n;
    }
}
}
public class Solution {

import java.util.*;

public class Solution {
    public int minTimeToFinish(int[] time, int[][] special) {
        int n = time.length;
        Map<Integer, Integer> map = new HashMap<>();
        for (int[] s : special) {
            map.put(s[0], s[1]);
        }
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = time[0];
        for (int i = 1; i < n; i++) {
            dp[i] = Math.min(dp[i - 1] + time[i], dp[i - 1] + time[i] / 2);
            if (map.containsKey(i)) {
                dp[i] = Math.min(dp[i], dp[i - 1] + map.get(i));
            }
        }
        return dp[n - 1];
    }
}
}
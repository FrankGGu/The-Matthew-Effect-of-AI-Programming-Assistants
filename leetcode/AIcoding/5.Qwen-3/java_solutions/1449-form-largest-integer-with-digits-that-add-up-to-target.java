public class Solution {

import java.util.*;

public class Solution {
    public String largestNumber(int[] cost, int target) {
        String[] dp = new String[target + 1];
        Arrays.fill(dp, "");
        dp[0] = "";

        for (int i = 1; i <= target; i++) {
            for (int j = 0; j < 9; j++) {
                int prev = i - cost[j];
                if (prev >= 0 && !dp[prev].equals("")) {
                    String candidate = dp[prev] + (char) ('1' + j);
                    if (candidate.length() > dp[i].length() || 
                        (candidate.length() == dp[i].length() && candidate.compareTo(dp[i]) > 0)) {
                        dp[i] = candidate;
                    }
                }
            }
        }

        return dp[target];
    }
}
}
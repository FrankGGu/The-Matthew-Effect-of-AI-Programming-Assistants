public class Solution {

import java.util.*;

public class Solution {
    public int mostPoints(int[][] questions) {
        int n = questions.length;
        int[] dp = new int[n];

        for (int i = n - 1; i >= 0; i--) {
            int take = questions[i][0] + (i + 1 < n ? dp[i + 1] : 0);
            int skip = i + 1 < n ? dp[i + 1] : 0;
            dp[i] = Math.max(take, skip);
        }

        return dp[0];
    }
}
}
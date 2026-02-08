public class Solution {

import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int maxScore(int[][] intervals) {
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0]));
        int n = intervals.length;
        int[] dp = new int[n];
        for (int i = 0; i < n; i++) {
            dp[i] = intervals[i][1];
            for (int j = 0; j < i; j++) {
                if (intervals[j][1] <= intervals[i][0]) {
                    dp[i] = Math.max(dp[i], dp[j] + intervals[i][1]);
                }
            }
        }
        int max = 0;
        for (int score : dp) {
            max = Math.max(max, score);
        }
        return max;
    }
}
}
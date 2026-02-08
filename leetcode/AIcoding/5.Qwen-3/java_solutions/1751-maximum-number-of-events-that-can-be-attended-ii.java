public class Solution {

import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int maxEvents(int[][] events) {
        Arrays.sort(events, Comparator.comparingInt(a -> a[1]));
        int n = events.length;
        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            int[] event = events[i];
            int start = event[0], end = event[1];
            int j = i;
            while (j >= 0 && events[j][1] >= start) {
                j--;
            }
            dp[i + 1] = Math.max(dp[i], dp[j + 1] + 1);
        }
        return dp[n];
    }
}
}
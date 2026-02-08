public class Solution {

import java.util.*;

public class Solution {
    public int bestTeamWinRate(int[] skills, int[] ages) {
        int n = skills.length;
        int[][] players = new int[n][2];
        for (int i = 0; i < n; i++) {
            players[i][0] = ages[i];
            players[i][1] = skills[i];
        }
        Arrays.sort(players, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
        int[] dp = new int[n];
        int max = 0;
        for (int i = 0; i < n; i++) {
            dp[i] = players[i][1];
            for (int j = 0; j < i; j++) {
                if (players[j][1] <= players[i][1]) {
                    dp[i] = Math.max(dp[i], dp[j] + players[i][1]);
                }
            }
            max = Math.max(max, dp[i]);
        }
        return max;
    }
}
}
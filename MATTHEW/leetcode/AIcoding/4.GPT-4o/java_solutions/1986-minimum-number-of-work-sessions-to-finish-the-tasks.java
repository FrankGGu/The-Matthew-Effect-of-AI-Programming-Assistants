import java.util.Arrays;

public class Solution {
    public int minSessions(int[] tasks, int sessionTime) {
        int n = tasks.length;
        int totalStates = 1 << n;
        int[] dp = new int[totalStates];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int state = 0; state < totalStates; state++) {
            if (dp[state] == Integer.MAX_VALUE) continue;
            for (int nextState = 0; nextState < totalStates; nextState++) {
                if ((state & nextState) == 0) {
                    int totalTime = 0;
                    for (int j = 0; j < n; j++) {
                        if ((nextState & (1 << j)) != 0) {
                            totalTime += tasks[j];
                        }
                    }
                    if (totalTime <= sessionTime) {
                        dp[state | nextState] = Math.min(dp[state | nextState], dp[state] + 1);
                    }
                }
            }
        }

        return dp[totalStates - 1];
    }
}
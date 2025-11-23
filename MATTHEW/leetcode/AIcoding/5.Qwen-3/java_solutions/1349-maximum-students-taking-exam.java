public class Solution {

import java.util.*;

public class Solution {
    public int maxStudents(char[][] seat) {
        int m = seat.length;
        int n = seat[0].length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int i = 0; i < m; i++) {
            int[] nextDp = new int[1 << n];
            Arrays.fill(nextDp, -1);
            for (int state = 0; state < (1 << n); state++) {
                if (dp[state] == -1) continue;
                for (int nextState = 0; nextState < (1 << n); nextState++) {
                    if ((state & nextState) != 0) continue;
                    boolean valid = true;
                    for (int j = 0; j < n; j++) {
                        if ((nextState & (1 << j)) != 0 && seat[i][j] != 'x') {
                            if (j > 0 && (nextState & (1 << (j - 1))) != 0) {
                                valid = false;
                                break;
                            }
                            if (j < n - 1 && (nextState & (1 << (j + 1))) != 0) {
                                valid = false;
                                break;
                            }
                        }
                    }
                    if (valid) {
                        int count = 0;
                        for (int j = 0; j < n; j++) {
                            if ((nextState & (1 << j)) != 0 && seat[i][j] != 'x') {
                                count++;
                            }
                        }
                        nextDp[nextState] = Math.max(nextDp[nextState], dp[state] + count);
                    }
                }
            }
            dp = nextDp;
        }

        int result = 0;
        for (int state = 0; state < (1 << n); state++) {
            result = Math.max(result, dp[state]);
        }
        return result;
    }
}
}
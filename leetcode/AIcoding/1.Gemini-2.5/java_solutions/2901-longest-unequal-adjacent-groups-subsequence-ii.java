import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<Integer> getLongestSubsequence(int[][] groups) {
        int n = groups.length;
        if (n == 0) {
            return new ArrayList<>();
        }

        int[] dp = new int[n];
        int[] prev = new int[n];

        for (int i = 0; i < n; i++) {
            dp[i] = 1;
            prev[i] = -1;
        }

        int maxLength = 1;
        int lastIndex = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                boolean areUnequal = (groups[j][0] != groups[i][0]) || (groups[j][1] != groups[i][1]);

                if (areUnequal) {
                    if (1 + dp[j] > dp[i]) {
                        dp[i] = 1 + dp[j];
                        prev[i] = j;
                    }
                }
            }

            if (dp[i] > maxLength) {
                maxLength = dp[i];
                lastIndex = i;
            }
        }

        List<Integer> resultIndices = new ArrayList<>();
        int curr = lastIndex;
        while (curr != -1) {
            resultIndices.add(curr);
            curr = prev[curr];
        }

        Collections.reverse(resultIndices);

        return resultIndices;
    }
}
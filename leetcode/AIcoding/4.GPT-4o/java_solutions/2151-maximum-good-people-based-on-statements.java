import java.util.*;

public class Solution {
    public int maximumGood(int[][] statements) {
        int n = statements.length;
        int maxGood = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            boolean valid = true;
            int goodCount = 0;

            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    goodCount++;
                    for (int j = 0; j < n; j++) {
                        if (statements[i][j] == 1 && (mask & (1 << j)) == 0) {
                            valid = false;
                            break;
                        } else if (statements[i][j] == 0 && (mask & (1 << j)) != 0) {
                            valid = false;
                            break;
                        }
                    }
                }
                if (!valid) break;
            }

            if (valid) {
                maxGood = Math.max(maxGood, goodCount);
            }
        }

        return maxGood;
    }
}
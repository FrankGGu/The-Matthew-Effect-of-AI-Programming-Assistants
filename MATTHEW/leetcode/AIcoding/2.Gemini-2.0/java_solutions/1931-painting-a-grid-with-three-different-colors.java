class Solution {
    private static final int MOD = 1000000007;

    public int colorTheGrid(int m, int n) {
        if (n == 0) {
            return 1;
        }

        int[][] validPatterns = generateValidPatterns(m);
        int patternCount = validPatterns.length;

        long[][] dp = new long[n][patternCount];

        for (int i = 0; i < patternCount; i++) {
            dp[0][i] = 1;
        }

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < patternCount; j++) {
                for (int k = 0; k < patternCount; k++) {
                    if (areCompatible(validPatterns[j], validPatterns[k])) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                    }
                }
            }
        }

        long total = 0;
        for (int i = 0; i < patternCount; i++) {
            total = (total + dp[n - 1][i]) % MOD;
        }

        return (int) total;
    }

    private int[][] generateValidPatterns(int m) {
        List<int[]> patterns = new ArrayList<>();
        generatePatterns(m, 0, new int[m], patterns);
        return patterns.toArray(new int[0][]);
    }

    private void generatePatterns(int m, int index, int[] currentPattern, List<int[]> patterns) {
        if (index == m) {
            patterns.add(currentPattern.clone());
            return;
        }

        for (int color = 1; color <= 3; color++) {
            if (index > 0 && currentPattern[index - 1] == color) {
                continue;
            }
            currentPattern[index] = color;
            generatePatterns(m, index + 1, currentPattern, patterns);
        }
    }

    private boolean areCompatible(int[] pattern1, int[] pattern2) {
        for (int i = 0; i < pattern1.length; i++) {
            if (pattern1[i] == pattern2[i]) {
                return false;
            }
        }
        return true;
    }
}
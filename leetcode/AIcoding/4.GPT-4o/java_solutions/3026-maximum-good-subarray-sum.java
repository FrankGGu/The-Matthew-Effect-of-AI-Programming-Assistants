class Solution {
    public long maximumGood(int[][] statements) {
        int n = statements.length;
        long maxGoodSum = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            boolean valid = true;
            long goodSum = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    goodSum += i + 1;
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
                maxGoodSum = Math.max(maxGoodSum, goodSum);
            }
        }
        return maxGoodSum;
    }
}
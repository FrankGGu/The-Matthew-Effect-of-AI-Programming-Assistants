class Solution {
    public int maximumGood(int[][] statements) {
        int n = statements.length;
        int max = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            boolean valid = true;
            for (int i = 0; i < n && valid; i++) {
                if ((mask & (1 << i)) != 0) {
                    for (int j = 0; j < n && valid; j++) {
                        if (statements[i][j] != 2 && statements[i][j] != ((mask >> j) & 1)) {
                            valid = false;
                        }
                    }
                }
            }
            if (valid) {
                max = Math.max(max, Integer.bitCount(mask));
            }
        }
        return max;
    }
}
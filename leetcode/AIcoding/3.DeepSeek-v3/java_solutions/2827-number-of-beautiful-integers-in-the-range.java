class Solution {
    private int[][][][] memo;
    private int k;
    private String high;

    public int numberOfBeautifulIntegers(int low, int high, int k) {
        this.k = k;
        this.high = Integer.toString(high);
        memo = new int[this.high.length()][2][this.high.length() + 1][this.high.length() + 1];
        for (int i = 0; i < memo.length; i++) {
            for (int j = 0; j < memo[i].length; j++) {
                for (int l = 0; l < memo[i][j].length; l++) {
                    Arrays.fill(memo[i][j][l], -1);
                }
            }
        }
        int upper = dfs(0, true, 0, 0);

        this.high = Integer.toString(low - 1);
        memo = new int[this.high.length()][2][this.high.length() + 1][this.high.length() + 1];
        for (int i = 0; i < memo.length; i++) {
            for (int j = 0; j < memo[i].length; j++) {
                for (int l = 0; l < memo[i][j].length; l++) {
                    Arrays.fill(memo[i][j][l], -1);
                }
            }
        }
        int lower = dfs(0, true, 0, 0);

        return upper - lower;
    }

    private int dfs(int pos, boolean isTight, int odd, int even) {
        if (pos == high.length()) {
            return (odd == even && (odd + even) > 0 && (odd + even) % k == 0) ? 1 : 0;
        }
        if (memo[pos][isTight ? 1 : 0][odd][even] != -1) {
            return memo[pos][isTight ? 1 : 0][odd][even];
        }
        int limit = isTight ? high.charAt(pos) - '0' : 9;
        int res = 0;
        for (int d = 0; d <= limit; d++) {
            boolean newIsTight = isTight && (d == limit);
            int newOdd = odd + (d % 2 == 1 ? 1 : 0);
            int newEven = even + (d % 2 == 0 ? 1 : 0);
            res += dfs(pos + 1, newIsTight, newOdd, newEven);
        }
        memo[pos][isTight ? 1 : 0][odd][even] = res;
        return res;
    }
}
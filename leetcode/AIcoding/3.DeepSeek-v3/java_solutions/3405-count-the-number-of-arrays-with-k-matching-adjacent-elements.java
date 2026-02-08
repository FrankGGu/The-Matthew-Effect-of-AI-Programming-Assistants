class Solution {
    private static final int MOD = 1_000_000_007;
    private Integer[][][] memo;

    public int numberOfArrays(int[] differences, int lower, int upper) {
        int n = differences.length;
        memo = new Integer[n + 1][2][2];
        return dfs(differences, 0, lower, upper, 0, 0);
    }

    private int dfs(int[] diff, int idx, int lower, int upper, int hasMin, int hasMax) {
        if (idx == diff.length) {
            return (hasMin == 1 && hasMax == 1) ? 1 : 0;
        }
        if (memo[idx][hasMin][hasMax] != null) {
            return memo[idx][hasMin][hasMax];
        }

        long res = 0;
        for (int num = lower; num <= upper; num++) {
            int nextNum = num + diff[idx];
            if (nextNum < lower || nextNum > upper) {
                continue;
            }
            int newHasMin = (num == lower || hasMin == 1) ? 1 : 0;
            int newHasMax = (num == upper || hasMax == 1) ? 1 : 0;
            res = (res + dfs(diff, idx + 1, lower, upper, newHasMin, newHasMax)) % MOD;
        }
        memo[idx][hasMin][hasMax] = (int) res;
        return (int) res;
    }
}
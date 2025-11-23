class Solution {
    private static final int MOD = (int)1e9 + 7;

    public int countBeautifulNumbers(int low, int high, int k) {
        return (countNumbers(high, k) - countNumbers(low - 1, k) + MOD) % MOD;
    }

    private int countNumbers(int n, int k) {
        String s = Integer.toString(n);
        int len = s.length();
        Integer[][][][] memo = new Integer[len][k][2][1 << 10];
        return dfs(0, 0, 1, 0, s, k, memo);
    }

    private int dfs(int pos, int mod, int tight, int mask, String s, int k, Integer[][][][] memo) {
        if (pos == s.length()) {
            return (mod == 0 && mask != 0) ? 1 : 0;
        }
        if (memo[pos][mod][tight][mask] != null) {
            return memo[pos][mod][tight][mask];
        }
        int limit = tight == 1 ? s.charAt(pos) - '0' : 9;
        int res = 0;
        for (int d = 0; d <= limit; d++) {
            int newTight = (tight == 1 && d == limit) ? 1 : 0;
            int newMod = (mod * 10 + d) % k;
            int newMask = mask;
            if (d != 0 || mask != 0) {
                newMask = mask | (1 << d);
            }
            res = (res + dfs(pos + 1, newMod, newTight, newMask, s, k, memo)) % MOD;
        }
        memo[pos][mod][tight][mask] = res;
        return res;
    }
}
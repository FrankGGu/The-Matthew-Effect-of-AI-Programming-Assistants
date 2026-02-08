class Solution {
    private static final int MOD = 1000000007;
    private Integer[][][] memo;

    public int countSteppingNumbers(String low, String high) {
        memo = new Integer[101][10][2];
        int highCount = dfs(high, 0, -1, true, true);
        memo = new Integer[101][10][2];
        int lowCount = dfs(low, 0, -1, true, true);
        int res = (highCount - lowCount + MOD) % MOD;
        if (isStepping(low)) {
            res = (res + 1) % MOD;
        }
        return res;
    }

    private int dfs(String num, int pos, int prevDigit, boolean isLeadingZero, boolean isTight) {
        if (pos == num.length()) {
            return isLeadingZero ? 0 : 1;
        }
        int limit = isTight ? num.charAt(pos) - '0' : 9;
        int memoKey = isLeadingZero ? 0 : 1;
        if (!isLeadingZero && memo[pos][prevDigit][memoKey] != null) {
            return memo[pos][prevDigit][memoKey];
        }
        int res = 0;
        for (int d = 0; d <= limit; d++) {
            boolean newIsTight = isTight && (d == limit);
            boolean newIsLeadingZero = isLeadingZero && (d == 0);
            if (newIsLeadingZero) {
                res = (res + dfs(num, pos + 1, prevDigit, newIsLeadingZero, newIsTight)) % MOD;
            } else {
                if (isLeadingZero || Math.abs(d - prevDigit) == 1) {
                    res = (res + dfs(num, pos + 1, d, newIsLeadingZero, newIsTight)) % MOD;
                }
            }
        }
        if (!isLeadingZero) {
            memo[pos][prevDigit][memoKey] = res;
        }
        return res;
    }

    private boolean isStepping(String s) {
        for (int i = 1; i < s.length(); i++) {
            if (Math.abs(s.charAt(i) - s.charAt(i - 1)) != 1) {
                return false;
            }
        }
        return true;
    }
}
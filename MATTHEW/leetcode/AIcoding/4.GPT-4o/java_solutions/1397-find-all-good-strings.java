class Solution {
    private int mod = 1000000007;
    private int n;
    private String s1, s2;
    private Set<Character> forbidden;

    public int countGoodStrings(int n, String s1, String s2, String evil) {
        this.n = n;
        this.s1 = s1;
        this.s2 = s2;
        this.forbidden = new HashSet<>();
        for (char c : evil.toCharArray()) {
            forbidden.add(c);
        }

        int[][][] dp = new int[n + 1][2][evil.length() + 1];
        for (int[][] arr : dp) {
            for (int[] a : arr) {
                Arrays.fill(a, -1);
            }
        }

        return dfs(0, 0, 0, dp);
    }

    private int dfs(int pos, int isLower, int evilCount, int[][][] dp) {
        if (evilCount == forbidden.size()) return 0;
        if (pos == n) return 1;
        if (dp[pos][isLower][evilCount] != -1) return dp[pos][isLower][evilCount];

        char start = isLower == 0 ? s1.charAt(pos) : 'a';
        char end = isLower == 0 ? s2.charAt(pos) : 'z';
        int total = 0;

        for (char c = start; c <= end; c++) {
            if (forbidden.contains(c)) continue;
            int nextEvilCount = (evilCount == forbidden.size()) ? evilCount : evilCount + 1;
            total = (total + dfs(pos + 1, isLower | (c > end), nextEvilCount, dp)) % mod;
        }

        return dp[pos][isLower][evilCount] = total;
    }
}
class Solution {
    private int low, high, k;
    private String s;
    private Integer[][][][] dp;

    public int numberOfBeautifulIntegers(int low, int high, int k) {
        this.low = low;
        this.high = high;
        this.k = k;
        return countBeautifulIntegers(high) - countBeautifulIntegers(low - 1);
    }

    private int countBeautifulIntegers(int num) {
        s = String.valueOf(num);
        int n = s.length();
        dp = new Integer[n][2][k][n + 1];
        return dfs(0, 1, 0, 0);
    }

    private int dfs(int i, int isLimit, int rem, int cnt) {
        if (i == s.length()) {
            return rem == 0 && cnt == s.length() / 2 ? 1 : 0;
        }
        if (dp[i][isLimit][rem][cnt] != null) {
            return dp[i][isLimit][rem][cnt];
        }
        int up = isLimit == 1 ? s.charAt(i) - '0' : 9;
        int ans = 0;
        for (int j = 0; j <= up; j++) {
            ans += dfs(i + 1, isLimit == 1 && j == up ? 1 : 0, (rem * 10 + j) % k, cnt + (j % 2 == 0 ? 1 : -1));
        }
        return dp[i][isLimit][rem][cnt] = ans;
    }
}
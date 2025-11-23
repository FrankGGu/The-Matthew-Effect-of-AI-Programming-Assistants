int dp[1001][1001];
const int MOD = 1e9 + 7;

int rearrangeSticks(int n, int k) {
    if (n == k) return 1;
    if (k == 0) return 0;
    if (dp[n][k] != 0) return dp[n][k];

    long long res = (long long)rearrangeSticks(n - 1, k - 1) + (long long)(n - 1) * rearrangeSticks(n - 1, k);
    return dp[n][k] = res % MOD;
}
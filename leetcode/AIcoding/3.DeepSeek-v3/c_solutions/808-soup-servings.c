double memo[200][200];

double dfs(int a, int b) {
    if (a <= 0 && b <= 0) return 0.5;
    if (a <= 0) return 1.0;
    if (b <= 0) return 0.0;
    if (memo[a][b] > 0) return memo[a][b];
    double res = 0.25 * (dfs(a-4, b) + dfs(a-3, b-1) + dfs(a-2, b-2) + dfs(a-1, b-3));
    return memo[a][b] = res;
}

double soupServings(int n) {
    if (n >= 4800) return 1.0;
    n = (n + 24) / 25;
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            memo[i][j] = -1.0;
        }
    }
    return dfs(n, n);
}
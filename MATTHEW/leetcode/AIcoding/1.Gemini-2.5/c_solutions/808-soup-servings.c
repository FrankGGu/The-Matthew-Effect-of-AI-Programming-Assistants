static double memo[201][201];

int max(int a, int b) {
    return a > b ? a : b;
}

double calculate_prob(int a, int b) {
    if (a <= 0 && b <= 0) {
        return 0.5;
    }
    if (a <= 0) {
        return 1.0;
    }
    if (b <= 0) {
        return 0.0;
    }

    if (memo[a][b] > -0.5) {
        return memo[a][b];
    }

    double prob = 0.25 * (
        calculate_prob(max(0, a - 4), b) +
        calculate_prob(max(0, a - 3), max(0, b - 1)) +
        calculate_prob(max(0, a - 2), max(0, b - 2)) +
        calculate_prob(max(0, a - 1), max(0, b - 3))
    );

    return memo[a][b] = prob;
}

double soupServings(int N) {
    if (N >= 4800) {
        return 0.5;
    }

    int n = (N + 24) / 25;

    for (int i = 0; i <= n; ++i) {
        for (int j = 0; j <= n; ++j) {
            memo[i][j] = -1.0;
        }
    }

    return calculate_prob(n, n);
}
def countBalancedPermutations(n: int) -> int:
    MOD = 10**9 + 7
    dp = [[0] * (n + 1) for _ in range(n + 1)]
    dp[0][0] = 1
    for i in range(n + 1):
        for j in range(i + 1):
            if i > 0:
                dp[i][j] = (dp[i][j] + dp[i - 1][j]) % MOD
            if j > 0:
                dp[i][j] = (dp[i][j] + dp[i][j - 1]) % MOD

    fact = [1] * (n + 1)
    for i in range(2, n + 1):
        fact[i] = (fact[i - 1] * i) % MOD

    return (dp[n][n] * fact[n]) % MOD
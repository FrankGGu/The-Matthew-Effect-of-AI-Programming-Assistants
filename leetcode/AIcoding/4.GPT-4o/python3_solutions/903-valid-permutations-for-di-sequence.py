def numPermsDISequence(S: str) -> int:
    MOD = 10**9 + 7
    n = len(S)
    dp = [[0] * (n + 1) for _ in range(n + 1)]
    dp[0][0] = 1

    for i in range(1, n + 1):
        if S[i - 1] == 'I':
            for j in range(i + 1):
                dp[i][j] = sum(dp[i - 1][k] for k in range(j)) % MOD
        else:
            for j in range(i + 1):
                dp[i][j] = sum(dp[i - 1][k] for k in range(j + 1, i + 1)) % MOD

    return sum(dp[n]) % MOD
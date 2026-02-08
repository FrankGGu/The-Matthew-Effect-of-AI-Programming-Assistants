def minNumberOfValidSubstrings(word: str, target: str) -> int:
    n = len(word)
    m = len(target)
    dp = [float('inf')] * (n + 1)
    dp[0] = 0

    for i in range(1, n + 1):
        dp[i] = dp[i - 1] + 1
        for j in range(1, min(i, m) + 1):
            if word[i-j:i] == target[:j]:
                dp[i] = min(dp[i], dp[i-j])

    return dp[n]
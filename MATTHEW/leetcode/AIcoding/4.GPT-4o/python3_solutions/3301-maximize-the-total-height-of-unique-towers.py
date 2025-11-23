def maxHeight(A):
    A.sort(reverse=True)
    dp = [0] * (len(A) + 1)

    for height in A:
        for i in range(len(dp) - 1, 0, -1):
            dp[i] = max(dp[i], dp[i - 1] + height)

    return max(dp)
def minimumBeautifulSum(n: int) -> int:
    if n == 0:
        return 0
    powers_of_five = []
    power = 1
    while power <= n:
        powers_of_five.append(power)
        power *= 5

    dp = [float('inf')] * (n + 1)
    dp[0] = 0

    for i in range(1, n + 1):
        for power in powers_of_five:
            if i - power >= 0:
                dp[i] = min(dp[i], dp[i - power] + power)
            else:
                break

    return dp[n]
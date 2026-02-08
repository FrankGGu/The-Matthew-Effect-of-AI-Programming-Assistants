def maxTasks(tasks, maxTime):
    tasks.sort(key=lambda x: x[0])  # Sort by the time required
    n = len(tasks)
    dp = [0] * (maxTime + 1)

    for time, profit in tasks:
        for t in range(maxTime, time - 1, -1):
            dp[t] = max(dp[t], dp[t - time] + profit)

    return max(dp)
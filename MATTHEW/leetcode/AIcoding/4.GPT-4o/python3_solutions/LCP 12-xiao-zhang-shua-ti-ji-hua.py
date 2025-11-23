def maxQuestions(questions, time):
    n = len(questions)
    dp = [0] * (time + 1)

    for i in range(n):
        q, t = questions[i]
        for j in range(time, t - 1, -1):
            dp[j] = max(dp[j], dp[j - t] + q)

    return max(dp)
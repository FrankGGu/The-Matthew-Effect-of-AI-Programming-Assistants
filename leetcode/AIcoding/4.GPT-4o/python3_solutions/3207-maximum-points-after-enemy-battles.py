def maxPoints(points: List[List[int]]) -> int:
    points.sort(key=lambda x: x[0])
    dp = [0] * (len(points) + 1)

    for i in range(len(points) - 1, -1, -1):
        dp[i] = points[i][1] + dp[i + 1]
        for j in range(i + 1, len(points)):
            if points[j][0] > points[i][0] + points[i][1]:
                break
            dp[i] = max(dp[i], points[i][1] + dp[j + 1])

    return dp[0]
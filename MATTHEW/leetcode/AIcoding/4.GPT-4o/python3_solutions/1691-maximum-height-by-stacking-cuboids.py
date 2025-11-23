def maxHeight(cuboids):
    cuboids = [sorted(cuboid) for cuboid in cuboids]
    cuboids.sort()

    dp = [0] * len(cuboids)
    for i in range(len(cuboids)):
        dp[i] = cuboids[i][2]
        for j in range(i):
            if cuboids[j][0] <= cuboids[i][0] and cuboids[j][1] <= cuboids[i][1] and cuboids[j][2] <= cuboids[i][2]:
                dp[i] = max(dp[i], dp[j] + cuboids[i][2])

    return max(dp)
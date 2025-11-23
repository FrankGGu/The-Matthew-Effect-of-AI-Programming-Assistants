func maxHeight(cuboids [][]int) int {
    for i := range cuboids {
        sort.Ints(cuboids[i])
    }
    sort.Slice(cuboids, func(i, j int) bool {
        return cuboids[i][0] < cuboids[j][0] || (cuboids[i][0] == cuboids[j][0] && cuboids[i][1] < cuboids[j][1]) || (cuboids[i][0] == cuboids[j][0] && cuboids[i][1] == cuboids[j][1] && cuboids[i][2] < cuboids[j][2])
    })

    n := len(cuboids)
    dp := make([]int, n)
    for i := range dp {
        dp[i] = cuboids[i][2]
    }

    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            if cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2] {
                dp[i] = max(dp[i], dp[j]+cuboids[i][2])
            }
        }
    }

    res := 0
    for _, height := range dp {
        res = max(res, height)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
package main

func maxHeight(cuboids [][]int) int {
    n := len(cuboids)
    for i := 0; i < n; i++ {
        sort.Ints(cuboids[i])
    }
    sort.Slice(cuboids, func(i, j int) bool {
        if cuboids[i][0] != cuboids[j][0] {
            return cuboids[i][0] < cuboids[j][0]
        }
        if cuboids[i][1] != cuboids[j][1] {
            return cuboids[i][1] < cuboids[j][1]
        }
        return cuboids[i][2] < cuboids[j][2]
    })
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = cuboids[i][2]
        for j := 0; j < i; j++ {
            if cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2] {
                dp[i] = max(dp[i], dp[j]+cuboids[i][2])
            }
        }
    }
    res := 0
    for _, v := range dp {
        res = max(res, v)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
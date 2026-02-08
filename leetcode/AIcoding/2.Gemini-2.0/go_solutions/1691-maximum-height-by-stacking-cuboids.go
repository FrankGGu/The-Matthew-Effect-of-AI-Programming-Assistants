import "sort"

func maxHeight(cuboids [][]int) int {
    for _, c := range cuboids {
        sort.Ints(c)
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

    n := len(cuboids)
    dp := make([]int, n)
    maxHeight := 0

    for i := 0; i < n; i++ {
        dp[i] = cuboids[i][2]
        for j := 0; j < i; j++ {
            if cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2] {
                dp[i] = max(dp[i], dp[j]+cuboids[i][2])
            }
        }
        maxHeight = max(maxHeight, dp[i])
    }

    return maxHeight
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
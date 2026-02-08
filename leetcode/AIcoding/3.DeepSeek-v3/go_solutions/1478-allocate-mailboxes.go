import (
	"math"
	"sort"
)

func minDistance(houses []int, k int) int {
    n := len(houses)
    if n <= k {
        return 0
    }
    sort.Ints(houses)

    cost := make([][]int, n)
    for i := range cost {
        cost[i] = make([]int, n)
    }
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            median := houses[(i+j)/2]
            total := 0
            for l := i; l <= j; l++ {
                total += abs(houses[l] - median)
            }
            cost[i][j] = total
        }
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }

    for i := 0; i < n; i++ {
        dp[i][1] = cost[0][i]
    }

    for l := 2; l <= k; l++ {
        for j := 0; j < n; j++ {
            for i := 0; i < j; i++ {
                if dp[i][l-1] + cost[i+1][j] < dp[j][l] {
                    dp[j][l] = dp[i][l-1] + cost[i+1][j]
                }
            }
        }
    }

    return dp[n-1][k]
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
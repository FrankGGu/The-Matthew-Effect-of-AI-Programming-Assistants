func countRoutes(locations []int, start int, finish int, fuel int) int {
    n := len(locations)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, fuel+1)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var solve func(int, int) int
    solve = func(curr int, remainingFuel int) int {
        if remainingFuel < 0 {
            return 0
        }

        if dp[curr][remainingFuel] != -1 {
            return dp[curr][remainingFuel]
        }

        count := 0
        if curr == finish {
            count = 1
        }

        for next := 0; next < n; next++ {
            if next != curr {
                cost := abs(locations[curr] - locations[next])
                count = (count + solve(next, remainingFuel-cost)) % 1000000007
            }
        }

        dp[curr][remainingFuel] = count
        return count
    }

    return solve(start, fuel)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
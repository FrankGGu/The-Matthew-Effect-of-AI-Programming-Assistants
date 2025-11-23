import "math"

func nthUglyNumber(n int) int {
    if n <= 0 {
        return 0 // Or handle as an error, problem constraints usually say n >= 1
    }

    dp := make([]int, n)
    dp[0] = 1

    p2, p3
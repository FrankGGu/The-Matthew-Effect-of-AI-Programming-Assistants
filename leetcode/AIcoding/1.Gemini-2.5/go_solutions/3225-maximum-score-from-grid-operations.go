import "math"

func maxScore(grid [][]int) int6_4 {
    rows := len(grid)
    cols := len(grid[0])

    // dp[c] stores the maximum score to reach a cell in the current row at column c.
    // Use int64 for scores to prevent overflow as per problem constraints
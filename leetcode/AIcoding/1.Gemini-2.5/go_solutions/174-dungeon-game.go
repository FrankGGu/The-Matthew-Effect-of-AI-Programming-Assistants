import "math"

func calculateMinimumHP(dungeon [][]int) int {
	m := len(dungeon)
	n := len(dungeon[0])

	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}
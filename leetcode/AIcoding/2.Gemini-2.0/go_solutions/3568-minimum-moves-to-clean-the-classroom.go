import (
	"fmt"
	"math"
)

func minimumMoves(grid []string) int {
	n := len(grid)
	m := len(grid[0])

	dirty := []struct{ x, y int }{}
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if grid[i][j] == 'd' {
				dirty = append(dirty, struct{ x, y int }{i, j})
			}
		}
	}

	k := len(dirty)
	if k == 0 {
		return 0
	}

	dist := make([][]int, k+1)
	for i := 0; i <= k; i++ {
		dist[i] = make([]int, k+1)
		for j := 0; j <= k; j++ {
			dist[i][j] = -1
		}
	}

	// Calculate distances between all pairs of dirty cells and the starting point
	start := struct{ x, y int }{0, 0}
	for i := 0; i < k; i++ {
		dist[0][i+1] = bfs(grid, start, dirty[i])
		dist[i+1][0] = dist[0][i+1]
	}

	for i := 0; i < k; i++ {
		for j := i + 1; j < k; j++ {
			d := bfs(grid, dirty[i], dirty[j])
			dist[i+1][j+1] = d
			dist[j+1][i+1] = d
		}
	}

	// Dynamic programming to find the minimum total distance
	dp := make([]int, 1<<k)
	for i := range dp {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for mask := 0; mask < (1 << k); mask++ {
		if dp[mask] == math.MaxInt32 {
			continue
		}
		for i := 0; i < k; i++ {
			if (mask & (1 << i)) == 0 {
				newMask := mask | (1 << i)
				dp[newMask] = min(dp[newMask], dp[mask]+dist[0][i+1])
				for j := 0; j < k; j++ {
					if i != j && (mask&(1<<j)) == 0 {
						newMask2 := newMask | (1 << j)
						if newMask2 != newMask {
							dp[newMask2] = min(dp[newMask2], dp[mask]+dist[0][i+1]+dist[i+1][j+1])
						}
					}
				}
			}
		}
	}

	return dp[(1<<k)-1]
}

func bfs(grid []string, start struct{ x, y int }, end struct{ x, y int }) int {
	n := len(grid)
	m := len(grid[0])

	queue := []struct {
		x     int
		y     int
		steps int
	}{start.x, start.y, 0}}
	visited := make([][]bool, n)
	for i := range visited {
		visited[i] = make([]bool, m)
	}
	visited[start.x][start.y] = true

	dx := []int{0, 0, 1, -1}
	dy := []int{1, -1, 0, 0}

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		if curr.x == end.x && curr.y == end.y {
			return curr.steps
		}

		for i := 0; i < 4; i++ {
			nx := curr.x + dx[i]
			ny := curr.y + dy[i]

			if nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] != 'x' && !visited[nx][ny] {
				visited[nx][ny] = true
				queue = append(queue, struct {
					x     int
					y     int
					steps int
				}{nx, ny, curr.steps + 1})
			}
		}
	}

	return -1 // Should not happen if a path always exists
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
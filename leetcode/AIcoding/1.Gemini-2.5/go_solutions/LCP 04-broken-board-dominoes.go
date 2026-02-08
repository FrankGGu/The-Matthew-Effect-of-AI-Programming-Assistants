var (
	m, n    int
	matchX  []int
	visited []bool
	adj     map[int][]int
	dx      = []int{0, 0, 1, -1}
	dy      = []int{1, -1, 0, 0}
)

func cellToID(r, c int) int {
	return r*n + c
}

func dfs(u int) bool {
	for _, v := range adj[u] {
		if !visited[v] {
			visited[v] = true
			if matchX[v] == -1 || dfs(matchX[v]) {
				matchX[v] = u
				return true
			}
		}
	}
	return false
}

func maxDominoes(board [][]bool) int {
	m = len(board)
	if m == 0 {
		return 0
	}
	n = len(board[0])
	if n == 0 {
		return 0
	}

	adj = make(map[int][]int)
	totalCells := m * n
	matchX = make([]int, totalCells)
	for i := range matchX {
		matchX[i] = -1
	}

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if board[r][c] {
				continue
			}

			if (r+c)%2 == 0 {
				uID := cellToID(r, c)
				for i := 0; i < 4; i++ {
					nr, nc := r+dx[i], c+dy[i]
					if nr >= 0 && nr < m && nc >= 0 && nc < n && !board[nr][nc] {
						vID := cellToID(nr, nc)
						adj[uID] = append(adj[uID], vID)
					}
				}
			}
		}
	}

	maxMatching := 0
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if board[r][c] {
				continue
			}
			if (r+c)%2 == 0 {
				uID := cellToID(r, c)
				visited = make([]bool, totalCells)
				if dfs(uID) {
					maxMatching++
				}
			}
		}
	}

	return maxMatching
}
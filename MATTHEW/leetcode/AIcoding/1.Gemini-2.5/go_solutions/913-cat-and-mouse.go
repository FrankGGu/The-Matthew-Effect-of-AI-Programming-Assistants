func catAndMouse(graph [][]int) int {
	N := len(graph)

	dp := make([][][]int, N)
	for i := range dp {
		dp[i] = make([][]int, N)
		for j := range dp[i] {
			dp[i][j] = make([]int, 2)
		}
	}

	outDegree := make([][][]int, N)
	for i := range outDegree {
		outDegree[i] = make([][]int, N)
		for j := range outDegree[i] {
			outDegree[i][j] = make([]int, 2)
			outDegree[i][j][0] = len(graph[i])

			catMoves := 0
			for _, nextCatPos := range graph[j] {
				if nextCatPos != 0 {
					catMoves++
				}
			}
			outDegree[i][j][1] = catMoves
		}
	}

	revGraph := make([][]int, N)
	for i := 0; i < N; i++ {
		for _, neighbor := range graph[i] {
			revGraph[neighbor] = append(revGraph[neighbor], i)
		}
	}

	type State struct {
		m, c, t int
	}
	q := []State{}

	for m := 0; m < N; m++ {
		for c := 0; c < N; c++ {
			if m == 0 {
				if dp[m][c][0] == 0 {
					dp[m][c][0] = 1
					q = append(q, State{m, c, 0})
				}
				if dp[m][c][1] == 0 {
					dp[m][c][1] = 1
					q = append(q, State{m, c, 1})
				}
			}
			if c == m {
				if m != 0 {
					if dp[m][c][0] == 0 {
						dp[m][c][0] = 2
						q = append(q, State{m, c, 0})
					}
					if dp[m][c][1] == 0 {
						dp[m][c][1] = 2
						q = append(q, State{m, c, 1})
					}
				}
			}
		}
	}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		m, c, t := curr.m, curr.c, curr.t
		winner := dp[m][c][t]

		if t == 0 {
			for _, prevCatPos := range revGraph[c] {
				if c == 0 {
					continue
				}
				if dp[m][prevCatPos][1] == 0 {
					if winner == 2 {
						dp[m][prevCatPos][1] = 2
						q = append(q, State{m, prevCatPos, 1})
					} else {
						outDegree[m][prevCatPos][1]--
						if outDegree[m][prevCatPos][1] == 0 {
							dp[m][prevCatPos][1] = 1
							q = append(q, State{m, prevCatPos, 1})
						}
					}
				}
			}
		} else {
			for _, prevMousePos := range revGraph[m] {
				if dp[prevMousePos][c][0] == 0 {
					if winner == 1 {
						dp[prevMousePos][c][0] = 1
						q = append(q, State{prevMousePos, c, 0})
					} else {
						outDegree[prevMousePos][c][0]--
						if outDegree[prevMousePos][c][0] == 0 {
							dp[prevMousePos][c][0] = 2
							q = append(q, State{prevMousePos, c, 0})
						}
					}
				}
			}
		}
	}

	return dp[1][2][0]
}
package main

func countPaths(grid [][]int, k int) int {
	m := len(grid)
	n := len(grid[0])

	totalSteps := m + n - 2
	halfSteps := totalSteps / 2

	memo1 := make([][]map[int]int, m)
	for i := range memo1 {
		memo1[i] = make([]map[int]int, n)
	}

	var dfs1 func(r, c, currentXOR int)
	dfs1 = func(r, c, currentXOR int) {
		currentXOR ^= grid[r][c]

		if r+c == halfSteps {
			if memo1[r][c] == nil {
				memo1[r][c] = make(map[int]int)
			}
			memo1[r][c][currentXOR]++
			return
		}

		if r+1 < m {
			dfs1(r+1, c, currentXOR)
		}
		if c+1 < n {
			dfs1(r, c+1, currentXOR)
		}
	}

	dfs1(0, 0, 0)

	memo2 := make([][]map[int]int, m)
	for i := range memo2 {
		memo2[i] = make([]map[int]int, n)
	}

	var dfs2 func(r, c, currentXOR int)
	dfs2 = func(r, c, currentXOR int) {
		currentXOR ^= grid[r][c]

		if (m-1-r)+(n-1-c) == totalSteps-halfSteps {
			if memo2[r][c] == nil {
				memo2[r][c] = make(map[int]int)
			}
			memo2[r][c][currentXOR]++
			return
		}

		if r-1 >= 0 {
			dfs2(r-1, c, currentXOR)
		}
		if c-1 >= 0 {
			dfs2(r, c-1, currentXOR)
		}
	}

	dfs2(m-1, n-1, 0)

	ans := 0
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if r+c == halfSteps {
				if memo1[r][c] != nil && memo2[r][c] != nil {
					for xor1, count1 := range memo1[r][c] {
						requiredXOR2 := xor1 ^ grid[r][c] ^ k
						if count2, found := memo2[r][c][requiredXOR2]; found {
							ans += count1 * count2
						}
					}
				}
			}
		}
	}

	return ans
}
import "fmt"

func getMaxGridHappiness(m int, n int, introvertsCount int, extrovertsCount int) int {
	dp := make([][][][][]int, m*n+1)
	for i := range dp {
		dp[i] = make([][][][]int, introvertsCount+1)
		for j := range dp[i] {
			dp[i][j] = make([][][]int, extrovertsCount+1)
			for k := range dp[i][j] {
				dp[i][j][k] = make([][]int, 3*3*3*3*3)
				for l := range dp[i][j][k] {
					dp[i][j][k][l] = make([]int, 2)
					for p := range dp[i][j][k][l] {
						dp[i][j][k][l][p] = -1
					}
				}
			}
		}
	}

	var solve func(idx int, introverts int, extroverts int, mask int, placed int) int
	solve = func(idx int, introverts int, extroverts int, mask int, placed int) int {
		if idx == m*n {
			return 0
		}
		if dp[idx][introverts][extroverts][mask][placed] != -1 {
			return dp[idx][introverts][extroverts][mask][placed]
		}

		maxHappiness := 0

		// Place nothing
		happiness := solve(idx+1, introverts, extroverts, (mask<<2)&0x1F, 0)
		if happiness > maxHappiness {
			maxHappiness = happiness
		}

		// Place introvert
		if introverts > 0 {
			happiness := 30
			row := idx / n
			col := idx % n

			if col > 0 && mask&1 == 1 {
				happiness -= 30 + 30
			}
			if row > 0 && (mask>>3)&1 == 1 {
				happiness -= 30 + 30
			}
			happiness += solve(idx+1, introverts-1, extroverts, (mask<<2)&0x1F, 1)
			if happiness > maxHappiness {
				maxHappiness = happiness
			}
		}

		// Place extrovert
		if extroverts > 0 {
			happiness := 20
			row := idx / n
			col := idx % n

			if col > 0 && mask&1 == 2 {
				happiness += 20 + 20
			}
			if row > 0 && (mask>>3)&1 == 2 {
				happiness += 20 + 20
			}
			happiness += solve(idx+1, introverts, extroverts-1, (mask<<2)&0x1F, 2)
			if happiness > maxHappiness {
				maxHappiness = happiness
			}
		}

		dp[idx][introverts][extroverts][mask][placed] = maxHappiness
		return maxHappiness
	}

	return solve(0, introvertsCount, extrovertsCount, 0, 0)
}
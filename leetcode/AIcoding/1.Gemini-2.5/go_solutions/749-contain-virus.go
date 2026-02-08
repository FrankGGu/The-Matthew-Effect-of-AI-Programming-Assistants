package main

type pair struct {
	r, c int
}

var dirs = []pair{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

func containVirus(grid [][]int) int {
	R := len(grid)
	C := len(grid[0])
	totalWalls := 0

	for {
		regions := [][][]pair{}
		perimeters := []int{}
		threats := [][]pair{}

		visited := make([][]bool, R)
		for i := range visited {
			visited[i] = make([]bool, C)
		}

		for r := 0; r < R; r++ {
			for c := 0; c < C; c++ {
				if grid[r][c] == 1 && !visited[r][c] {
					currentRegionCells := []pair{}
					currentPerimeter := 0
					currentThreatsMap := make(map[pair]bool)

					q := []pair{{r, c}}
					visited[r][c] = true
					currentRegionCells = append(currentRegionCells, pair{r, c})

					head := 0
					for head < len(q) {
						curr := q[head]
						head++

						for _, dir := range dirs {
							nr, nc := curr.r+dir.r, curr.c+dir.c

							if nr >= 0 && nr < R && nc >= 0 && nc < C {
								if grid[nr][nc] == 0 {
									currentPerimeter++
									currentThreatsMap[pair{nr, nc}] = true
								} else if grid[nr][nc] == 1 && !visited[nr][nc] {
									visited[nr][nc] = true
									q = append(q, pair{nr, nc})
									currentRegionCells = append(currentRegionCells, pair{nr, nc})
								}
							}
						}
					}

					currentThreatsList := []pair{}
					for p := range currentThreatsMap {
						currentThreatsList = append(currentThreatsList, p)
					}

					regions = append(regions, currentRegionCells)
					perimeters = append(perimeters, currentPerimeter)
					threats = append(threats, currentThreatsList)
				}
			}
		}

		if len(regions) == 0 {
			break
		}

		bestRegionIdx := -1
		maxThreats := -1
		for i := 0; i < len(regions); i++ {
			if len(threats[i]) > maxThreats {
				maxThreats = len(threats[i])
				bestRegionIdx = i
			}
		}

		if maxThreats == 0 {
			break
		}

		totalWalls += perimeters[bestRegionIdx]
		for _, p := range regions[bestRegionIdx] {
			grid[p.r][p.c] = 2
		}

		for i := 0; i < len(regions); i++ {
			if i == bestRegionIdx {
				continue
			}
			for _, p := range threats[i] {
				if grid[p.r][p.c] == 0 {
					grid[p.r][p.c] = 1
				}
			}
		}
	}

	return totalWalls
}
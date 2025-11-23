func robotSim(commands []int, obstacles [][]int) int {
	dx := []int{0, 1, 0, -1}
	dy := []int{1, 0, -1, 0}
	x := 0
	y := 0
	di := 0
	obstacleSet := make(map[int]map[int]bool)
	for _, obs := range obstacles {
		ox := obs[0]
		oy := obs[1]
		if _, ok := obstacleSet[ox]; !ok {
			obstacleSet[ox] = make(map[int]bool)
		}
		obstacleSet[ox][oy] = true
	}
	ans := 0
	for _, command := range commands {
		if command == -2 {
			di = (di + 3) % 4
		} else if command == -1 {
			di = (di + 1) % 4
		} else {
			for k := 0; k < command; k++ {
				nx := x + dx[di]
				ny := y + dy[di]
				if _, ok := obstacleSet[nx]; ok {
					if _, ok2 := obstacleSet[nx][ny]; ok2 {
						break
					}
				}
				x = nx
				y = ny
				ans = max(ans, x*x+y*y)
			}
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
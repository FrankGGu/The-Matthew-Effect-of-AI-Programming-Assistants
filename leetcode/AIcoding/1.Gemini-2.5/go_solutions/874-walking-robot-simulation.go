package main

func robotSim(commands []int, obstacles [][]int) int {
	dx := []int{0, 1, 0, -1} // North, East, South, West
	dy := []int{1, 0, -1, 0} // North, East, South, West

	x, y := 0, 0
	dir := 0 // 0: North, 1: East, 2: South, 3: West
	maxDistSq := 0

	obstacleSet := make(map[int]map[int]struct{})
	for _, obs := range obstacles {
		ox, oy := obs[0], obs[1]
		if _, ok := obstacleSet[ox]; !ok {
			obstacleSet[ox] = make(map[int]struct{})
		}
		obstacleSet[ox][oy] = struct{}{}
	}

	for _, cmd := range commands {
		if cmd == -2 { // Turn left
			dir = (dir + 3) % 4
		} else if cmd == -1 { // Turn right
			dir = (dir + 1) % 4
		} else { // Move forward `cmd` steps
			for i := 0; i < cmd; i++ {
				nextX, nextY := x+dx[dir], y+dy[dir]

				isObstacle := false
				if _, ok := obstacleSet[nextX]; ok {
					if _, ok := obstacleSet[nextX][nextY]; ok {
						isObstacle = true
					}
				}

				if isObstacle {
					break // Robot stops moving for this command
				} else {
					x, y = nextX, nextY
					currentDistSq := x*x + y*y
					if currentDistSq > maxDistSq {
						maxDistSq = currentDistSq
					}
				}
			}
		}
	}

	return maxDistSq
}
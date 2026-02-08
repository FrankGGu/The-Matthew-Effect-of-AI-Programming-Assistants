func robot(command string, obstacles [][]int, x int, y int) []bool {
	commandLen := len(command)

	// Precompute path points for one cycle
	// pathPoints[i] stores the (x, y) coordinate after i steps of the command.
	// pathPoints[0] is (0,0).
	// pathPoints[commandLen] is the coordinate after one full command cycle.
	pathPoints := make([][2]int, commandLen+1)
	pathPoints[0] = [2]int{0, 0}
	currX, currY := 0, 0
	for i := 0; i < commandLen; i++ {
		if command[i] == 'R' {
			currX++
		} else { // command[i] == 'U'
			currY++
		}
		pathPoints[i+1] = [2]int{currX, currY}
	}

	// finalX, finalY are the net displacement after one full command cycle.
	finalX, finalY := pathPoints[commandLen][0], pathPoints[commandLen][1]

	// getReachInfo is a helper function to determine if a target coordinate (targetX, targetY)
	// is reachable by the robot. If reachable, it returns true along with the number of
	// full cycles (k) and steps into the last cycle (j) when it's reached.
	// This (k, j) pair represents the earliest time the target is reached.
	getReachInfo := func(targetX, targetY int) (bool, int, int) {
		// Iterate through all possible partial cycle steps (j)
		for j := 0; j <= commandLen; j++ {
			// px, py are the coordinates after j steps into a cycle.
			px, py := pathPoints[j][0], pathPoints[j][1]

			// If targetX or targetY is less than px or py, it's impossible to reach
			// because the robot only moves right or up.
			if targetX < px || targetY < py {
				continue
			}

			// Case 1: Robot returns to (0,0) after each full cycle (finalX=0, finalY=0).
			// In this case, it can only reach points within the first cycle.
			if finalX == 0 && finalY == 0 {
				if targetX == px && targetY == py {
					return true, 0, j // Reached within the first cycle (k=0)
				}
				continue
			}

			// Case 2: Robot moves only vertically after full cycle (finalX=0, finalY>0).
			if finalX == 0 {
				if targetX != px { // Target X must match the X coordinate of the partial path.
					continue
				}
				// Check if the remaining vertical distance (targetY - py) is a multiple of finalY.
				if (targetY-py)%finalY == 0 {
					k := (targetY - py) / finalY
					if k >= 0 { // k must be non-negative
						return true, k, j
					}
				}
				continue
			}

			// Case 3: Robot moves only horizontally after full cycle (finalX>0, finalY=0).
			if finalY == 0 {
				if targetY != py { // Target Y must match the Y coordinate of the partial path.
					continue
				}
				// Check if the remaining horizontal distance (targetX - px) is a multiple of finalX.
				if (targetX-px)%finalX == 0 {
					k := (targetX - px) / finalX
					if k >= 0 { // k must be non-negative
						return true, k, j
					}
				}
				continue
			}

			// Case 4: Robot moves both horizontally and vertically after full cycle (finalX>0, finalY>0).
			// Check if both remaining distances are multiples of their respective final displacements.
			if (targetX-px)%finalX == 0 && (targetY-py)%finalY == 0 {
				k1 := (targetX - px) / finalX
				k2 := (targetY - py) / finalY
				// The number of full cycles (k) must be the same for both dimensions and non-negative.
				if k1 >= 0 && k2 >= 0 && k1 == k2 {
					return true, k1, j
				}
			}
		}
		return false, -1, -1 // Not reachable
	}

	// Get reach information for the ultimate target (x, y)
	targetReached, kTarget, jTarget := getReachInfo(x, y)
	var timeTarget int
	if targetReached {
		timeTarget = kTarget*commandLen + jTarget
	}

	ans := make([]bool, len(obstacles))
	for i, obs := range obstacles {
		ox, oy := obs[0], obs[1]

		// An obstacle is considered "before" (x, y) if it's within the bounding box of (x, y)
		// and reached at an earlier or equal time.
		// If the obstacle is outside the target rectangle, it cannot be reached "before" (x,y).
		if ox > x || oy > y {
			ans[i] = false
			continue
		}

		// Get reach information for the current obstacle
		obsReached, kObs, jObs := getReachInfo(ox, oy)

		if !obsReached {
			ans[i] = false // Obstacle is not reachable
			continue
		}

		if !targetReached {
			ans[i] = true // Obstacle is reachable, but the ultimate target (x,y) is never reached.
			continue
		}

		// Both obstacle and target are reachable. Compare their "time" (total steps).
		timeObs := kObs*commandLen + jObs
		ans[i] = (timeObs <= timeTarget)
	}

	return ans
}
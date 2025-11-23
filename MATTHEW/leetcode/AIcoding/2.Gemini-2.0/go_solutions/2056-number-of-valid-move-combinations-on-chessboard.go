func numberOfCombinations(pieces []string, positions [][]int) int {
	n := len(pieces)
	mod := int(1e9 + 7)
	maxSteps := make([]int, n)

	for i := 0; i < n; i++ {
		if pieces[i] == "queen" {
			maxSteps[i] = 8
		} else if pieces[i] == "rook" {
			maxSteps[i] = 4
		} else {
			maxSteps[i] = 4
		}
	}

	var count int
	var dfs func(int, []int)

	dfs = func(index int, steps []int) {
		if index == n {
			count = (count + 1) % mod
			return
		}

		for step := 1; step <= 8; step++ {
			valid := true
			newSteps := make([]int, len(steps))
			copy(newSteps, steps)
			newSteps = append(newSteps, step)

			validPosition := func(i int, step int) bool {
				x := positions[i][0]
				y := positions[i][1]
				piece := pieces[i]

				if piece == "rook" {
					if step == 1 { // up
						if x-step < 1 {
							return false
						}
					} else if step == 2 { // down
						if x+step > 8 {
							return false
						}
					} else if step == 3 { // left
						if y-step < 1 {
							return false
						}
					} else if step == 4 { // right
						if y+step > 8 {
							return false
						}
					} else {
						return false
					}
				} else if piece == "bishop" {
					if step == 1 { // up-left
						if x-step < 1 || y-step < 1 {
							return false
						}
					} else if step == 2 { // up-right
						if x-step < 1 || y+step > 8 {
							return false
						}
					} else if step == 3 { // down-left
						if x+step > 8 || y-step < 1 {
							return false
						}
					} else if step == 4 { // down-right
						if x+step > 8 || y+step > 8 {
							return false
						}
					} else {
						return false
					}
				} else {
					if step == 1 { // up
						if x-step < 1 {
							return false
						}
					} else if step == 2 { // down
						if x+step > 8 {
							return false
						}
					} else if step == 3 { // left
						if y-step < 1 {
							return false
						}
					} else if step == 4 { // right
						if y+step > 8 {
							return false
						}
					} else if step == 5 { // up-left
						if x-step < 1 || y-step < 1 {
							return false
						}
					} else if step == 6 { // up-right
						if x-step < 1 || y+step > 8 {
							return false
						}
					} else if step == 7 { // down-left
						if x+step > 8 || y-step < 1 {
							return false
						}
					} else if step == 8 { // down-right
						if x+step > 8 || y+step > 8 {
							return false
						}
					} else {
						return false
					}
				}
				return true
			}

			if newSteps[index] > maxSteps[index] {
				continue
			}

			if !validPosition(index, step) {
				continue
			}

			dfs(index+1, newSteps)
		}
	}

	dfs(0, []int{})

	return count
}
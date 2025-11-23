func avoidFlood(rains []int) []int {
	n := len(rains)
	ans := make([]int, n)
	for i := range ans {
		ans[i] = 1
	}
	dry := []int{}
	lake := make(map[int]int)

	for i, r := range rains {
		if r > 0 {
			if _, ok := lake[r]; ok {
				return []int{}
			}
			lake[r] = i
			ans[i] = -1
		} else {
			dry = append(dry, i)
		}

		if r > 0 {
			for j := 0; j < len(dry); j++ {
				nextRainDay, ok := lake[r]
				if !ok {
					break
				}

				if dry[j] < i && dry[j] < nextRainDay {
					canDry := true
					for k := 0; k < len(rains); k++ {
						if rains[k] == r && k > dry[j] && k < i {
							canDry = false
							break
						}
					}

					if canDry {
						ans[dry[j]] = r
						dry = append(dry[:j], dry[j+1:]...)
						j--
						break
					}
				}
			}
		}
	}
	return ans
}
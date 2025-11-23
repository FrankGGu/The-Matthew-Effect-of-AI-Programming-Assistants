package main

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func countPairs(points [][]int, k int) int {
	ans := 0
	freq := make(map[int]map[int]int)

	for _, p := range points {
		x := p[0]
		y := p[1]

		for diffX := -k; diffX <= k; diffX++ {
			diffYAbs := k - abs(diffX)

			targetPx := x - diffX

			// Case 1: diffYAbs == 0
			// This means |diffX| = k and diffY = 0.
			// We are looking for a point (targetPx, y).
			if diffYAbs == 0 {
				if countMap, ok := freq[targetPx]; ok {
					if count, ok2 := countMap[y]; ok2 {
						ans += count
					}
				}
			} else { // Case 2: diffYAbs > 0
				// This means diffY can be diffYAbs or -diffYAbs.
				// We are looking for points (targetPx, y - diffYAbs) and (targetPx, y + diffYAbs).

				// Check for targetPy = y - diffYAbs
				targetPy1 := y - diffYAbs
				if countMap, ok := freq[targetPx]; ok {
					if count, ok2 := countMap[targetPy1]; ok2 {
						ans += count
					}
				}

				// Check for targetPy = y + diffYAbs
				targetPy2 := y + diffYAbs
				if countMap, ok := freq[targetPx]; ok {
					if count, ok2 := countMap[targetPy2]; ok2 {
						ans += count
					}
				}
			}
		}

		// Add current point (x, y) to the frequency map
		if _, ok := freq[x]; !ok {
			freq[x] = make(map[int]int)
		}
		freq[x][y]++
	}

	return ans
}
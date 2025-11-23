import "math"

func flipgame(fronts []int, backs []int) int {
	badNumbers := make(map[int]bool)
	for i := 0; i < len(fronts); i++ {
		if fronts[i] == backs[i] {
			badNumbers[fronts[i]] = true
		}
	}

	minX := math.MaxInt32

	for _, num := range fronts {
		if !badNumbers[num] {
			if num < minX {
				minX = num
			}
		}
	}

	for _, num := range backs {
		if !badNumbers[num] {
			if num < minX {
				minX = num
			}
		}
	}

	return minX
}
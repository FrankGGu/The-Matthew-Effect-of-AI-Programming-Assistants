import "math"

func flipgame(fronts []int, backs []int) int {
	bad := make(map[int]bool)
	for i := 0; i < len(fronts); i++ {
		if fronts[i] == backs[i] {
			bad[fronts[i]] = true
		}
	}

	minGood := math.MaxInt32
	for i := 0; i < len(fronts); i++ {
		if !bad[fronts[i]] && fronts[i] < minGood {
			minGood = fronts[i]
		}
		if !bad[backs[i]] && backs[i] < minGood {
			minGood = backs[i]
		}
	}

	if minGood == math.MaxInt32 {
		return 0
	}
	return minGood
}
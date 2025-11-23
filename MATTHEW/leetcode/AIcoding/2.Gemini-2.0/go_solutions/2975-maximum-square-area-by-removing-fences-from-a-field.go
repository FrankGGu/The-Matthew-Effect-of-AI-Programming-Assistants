import (
	"sort"
)

func maximizeSquareArea(n int, m int, hFences []int, vFences []int) int {
	hFences = append(hFences, 1, n)
	vFences = append(vFences, 1, m)
	sort.Ints(hFences)
	sort.Ints(vFences)

	hDiffs := make(map[int]bool)
	for i := 0; i < len(hFences); i++ {
		for j := i + 1; j < len(hFences); j++ {
			hDiffs[hFences[j]-hFences[i]] = true
		}
	}

	maxSide := 0
	for i := 0; i < len(vFences); i++ {
		for j := i + 1; j < len(vFences); j++ {
			side := vFences[j] - vFences[i]
			if hDiffs[side] {
				if side > maxSide {
					maxSide = side
				}
			}
		}
	}

	if maxSide == 0 {
		return -1
	}

	const mod = 1000000007
	result := 1
	for i := 0; i < 2; i++ {
		result = (result * maxSide) % mod
	}
	return result
}
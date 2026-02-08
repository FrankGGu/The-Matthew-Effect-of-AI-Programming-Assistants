import (
	"sort"
)

func closetTarget(clothes []string, target string) int {
	n := len(clothes)
	if n == 0 {
		return -1
	}

	idx := -1
	for i := 0; i < n; i++ {
		if clothes[i] == target {
			idx = i
			break
		}
	}

	if idx == -1 {
		return -1
	}

	minDist := n
	for i := 0; i < n; i++ {
		if clothes[i] == target && i != idx {
			dist := abs(i - idx)
			minDist = min(minDist, dist)
			dist = abs(n - abs(i - idx))
			minDist = min(minDist, dist)
		}
	}

	if minDist == n {
		return -1
	}

	return minDist
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func rearrangeClothes(clothes []string) []string {
	sort.Strings(clothes)
	return clothes
}
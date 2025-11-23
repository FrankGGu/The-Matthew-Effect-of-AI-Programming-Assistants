import "math"

func minCost(n int, s int, t int, dist []int) int {
	if s == t {
		return 0
	}

	cost1 := 0
	curr := s
	for curr != t {
		cost1 += dist[curr]
		curr = (curr + 1) % n
	}

	cost2 := 0
	curr = s
	for curr != t {
		curr = (curr - 1 + n) % n
		cost2 += dist[curr]
	}

	return int(math.Min(float64(cost1), float64(cost2)))
}
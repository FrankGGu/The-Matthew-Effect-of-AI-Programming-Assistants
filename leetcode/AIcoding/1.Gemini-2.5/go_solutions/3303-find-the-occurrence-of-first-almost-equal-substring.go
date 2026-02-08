import "math"

func findTheFirstAlmostEqualSubstring(s string, target string, maxCost int) int {
	n := len(s)
	k := len(target)

	if k > n {
		return -1
	}

	for i := 0; i <= n-k; i++ {
		currentCost := 0
		for p := 0; p < k; p++ {
			cost := int(math.Abs(float64(s[i+p]) - float64(target[p])))
			currentCost += cost
		}
		if currentCost <= maxCost {
			return i
		}
	}

	return -1
}
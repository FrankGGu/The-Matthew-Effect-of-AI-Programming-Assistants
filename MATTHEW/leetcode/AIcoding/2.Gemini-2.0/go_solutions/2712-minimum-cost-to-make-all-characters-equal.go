import "math"

func minCost(s string, cost []int) int64 {
	n := len(s)
	var ans int64
	for i := 0; i < n-1; {
		j := i
		sum := 0
		maxCost := 0
		for j < n-1 && s[j] == s[j+1] {
			sum += cost[j]
			maxCost = int(math.Max(float64(maxCost), float64(cost[j])))
			j++
		}
		if j == i {
			i++
			continue
		}
		sum += cost[j]
		maxCost = int(math.Max(float64(maxCost), float64(cost[j])))
		ans += int64(sum - maxCost)
		i = j + 1
	}
	return ans
}
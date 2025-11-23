import "sort"

func minimumCost(cost []int) int {
	sort.Ints(cost)
	n := len(cost)
	ans := 0
	for i := n - 1; i >= 0; i -= 3 {
		ans += cost[i]
		if i-1 >= 0 {
			ans += cost[i-1]
		}
	}
	return ans
}
import (
	"sort"
)

func minimumCost(cost []int) int {
	sort.Sort(sort.Reverse(sort.IntSlice(cost)))

	totalCost := 0
	for i := 0; i < len(cost); i++ {
		if (i+1)%3 != 0 {
			totalCost += cost[i]
		}
	}
	return totalCost
}
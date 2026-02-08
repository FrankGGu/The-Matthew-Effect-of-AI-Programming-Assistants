import "sort"

func maxIncreasingGroups(usageLimits []int) int {
	sort.Ints(usageLimits)
	n := len(usageLimits)
	sum := 0
	groups := 0
	for i := 0; i < n; i++ {
		sum += usageLimits[i]
		if sum >= (groups+1)*(groups+2)/2 {
			groups++
		}
	}
	return groups
}
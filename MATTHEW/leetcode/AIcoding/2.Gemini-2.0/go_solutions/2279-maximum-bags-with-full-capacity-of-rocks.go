import "sort"

func maximumBags(capacity []int, rocks []int, additionalRocks int) int {
	n := len(capacity)
	diff := make([]int, n)
	for i := 0; i < n; i++ {
		diff[i] = capacity[i] - rocks[i]
	}
	sort.Ints(diff)
	count := 0
	for i := 0; i < n; i++ {
		if additionalRocks >= diff[i] {
			additionalRocks -= diff[i]
			count++
		} else {
			break
		}
	}
	return count
}
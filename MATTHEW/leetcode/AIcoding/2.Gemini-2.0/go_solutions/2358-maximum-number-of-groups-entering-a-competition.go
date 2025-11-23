import (
	"sort"
)

func maximumGroups(grades []int) int {
	sort.Ints(grades)
	n := len(grades)
	count := 0
	sum := 0
	members := 0
	for i := 0; i < n; i++ {
		sum += grades[i]
		members++
		if sum > 0 && sum > (count * (count + 1) / 2) {
			count++
		} else {
			members--
			sum -= grades[i]
		}
	}
	return count
}
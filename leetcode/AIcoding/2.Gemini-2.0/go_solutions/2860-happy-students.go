import "sort"

func maximumGroups(grades []int) int {
	sort.Ints(grades)
	n := len(grades)
	count := 0
	sum := 0
	groupSize := 1
	for i := 0; i < n; {
		if sum+groupSize <= n-i {
			sum += groupSize
			count++
			i += groupSize
			groupSize++
		} else {
			break
		}
	}
	return count
}
import "sort"

func successfulPairs(spells []int, potions []int, success int64) []int {
	n := len(spells)
	m := len(potions)
	sort.Ints(potions)
	result := make([]int, n)

	for i := 0; i < n; i++ {
		l, r := 0, m
		for l < r {
			mid := l + (r-l)/2
			if int64(spells[i])*int64(potions[mid]) >= success {
				r = mid
			} else {
				l = mid + 1
			}
		}
		result[i] = m - l
	}

	return result
}
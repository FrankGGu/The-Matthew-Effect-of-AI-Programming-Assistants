import "sort"

func canDistribute(quantities []int, n int) bool {
	sort.Ints(quantities)
	items := make([]int, n)
	for i := 0; i < n; i++ {
		items[i] = 1
	}

	for i := len(quantities) - 1; i >= 0; i-- {
		q := quantities[i]
		idx := -1
		maxVal := -1
		for j := 0; j < n; j++ {
			if items[j] >= q && (idx == -1 || items[j] < maxVal) {
				idx = j
				maxVal = items[j]
			}
		}

		if idx != -1 {
			items[idx] -= q
		} else {
			return false
		}
	}

	return true
}
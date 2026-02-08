import "sort"

func maximumBeauty(items [][]int, queries []int) []int {
	sort.Slice(items, func(i, j int) bool {
		return items[i][0] < items[j][0]
	})

	maxBeauty := 0
	for i := range items {
		maxBeauty = max(maxBeauty, items[i][1])
		items[i][1] = maxBeauty
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		l, r := 0, len(items)-1
		ans := 0
		for l <= r {
			mid := l + (r-l)/2
			if items[mid][0] <= query {
				ans = items[mid][1]
				l = mid + 1
			} else {
				r = mid - 1
			}
		}
		result[i] = ans
	}
	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
package main

func maximumBeauty(items [][2]int, queries []int) []int {
	sort.Slice(items, func(i, j int) bool {
		return items[i][0] < items[j][0]
	})
	maxBeauty := make([]int, len(items))
	maxBeauty[0] = items[0][1]
	for i := 1; i < len(items); i++ {
		maxBeauty[i] = max(maxBeauty[i-1], items[i][1])
	}
	result := make([]int, len(queries))
	for i := range queries {
		left, right := 0, len(items)-1
		best := -1
		for left <= right {
			mid := left + (right-left)/2
			if items[mid][0] <= queries[i] {
				best = mid
				left = mid + 1
			} else {
				right = mid - 1
			}
		}
		if best != -1 {
			result[i] = maxBeauty[best]
		}
	}
	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
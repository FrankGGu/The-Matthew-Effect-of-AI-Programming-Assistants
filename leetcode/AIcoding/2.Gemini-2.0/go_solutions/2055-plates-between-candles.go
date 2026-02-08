func platesBetweenCandles(s string, queries [][]int) []int {
	n := len(s)
	candleIndices := []int{}
	for i := 0; i < n; i++ {
		if s[i] == '|' {
			candleIndices = append(candleIndices, i)
		}
	}

	m := len(queries)
	result := make([]int, m)

	for i := 0; i < m; i++ {
		start := queries[i][0]
		end := queries[i][1]

		left := -1
		right := -1

		l, r := 0, len(candleIndices)-1
		for l <= r {
			mid := l + (r-l)/2
			if candleIndices[mid] >= start {
				left = candleIndices[mid]
				r = mid - 1
			} else {
				l = mid + 1
			}
		}

		l, r = 0, len(candleIndices)-1
		for l <= r {
			mid := l + (r-l)/2
			if candleIndices[mid] <= end {
				right = candleIndices[mid]
				l = mid + 1
			} else {
				r = mid - 1
			}
		}

		if left == -1 || right == -1 || left >= right {
			result[i] = 0
		} else {
			count := 0
			for j := left + 1; j < right; j++ {
				if s[j] == '*' {
					count++
				}
			}
			result[i] = count
		}
	}

	return result
}
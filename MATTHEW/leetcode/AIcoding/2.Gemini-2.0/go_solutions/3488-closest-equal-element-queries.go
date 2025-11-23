func closest(arr []int, queries [][]int) []int {
	n := len(arr)
	m := len(queries)
	ans := make([]int, m)
	for i := 0; i < m; i++ {
		idx, val := queries[i][0], queries[i][1]
		left, right := -1, -1
		for j := idx - 1; j >= 0; j-- {
			if arr[j] == val {
				left = j
				break
			}
		}
		for j := idx + 1; j < n; j++ {
			if arr[j] == val {
				right = j
				break
			}
		}
		if left == -1 && right == -1 {
			ans[i] = -1
		} else if left == -1 {
			ans[i] = right - idx
		} else if right == -1 {
			ans[i] = idx - left
		} else {
			ans[i] = min(right-idx, idx-left)
		}
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
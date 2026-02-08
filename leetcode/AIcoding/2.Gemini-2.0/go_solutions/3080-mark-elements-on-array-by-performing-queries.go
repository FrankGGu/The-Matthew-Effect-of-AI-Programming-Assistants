func markElements(nums []int, queries [][]int) []int {
	n := len(nums)
	m := len(queries)
	marked := make([]bool, n)
	res := make([]int, m)

	for i := 0; i < m; i++ {
		t, idx, val := queries[i][0], queries[i][1], queries[i][2]
		if t == 1 {
			if idx >= 0 && idx < n {
				nums[idx] += val
			}
		} else {
			count := 0
			for j := 0; j < n; j++ {
				if nums[j] > val && !marked[j] {
					marked[j] = true
					count++
				}
			}
			res[i] = count
		}
	}

	return res
}
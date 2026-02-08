func minDifference(nums []int, queries [][]int) []int {
	n := len(nums)
	m := len(queries)
	positions := make([][]int, 101)
	for i := 0; i < n; i++ {
		num := nums[i]
		positions[num] = append(positions[num], i)
	}
	result := make([]int, m)
	for i := 0; i < m; i++ {
		start := queries[i][0]
		end := queries[i][1]
		last := -1
		minDiff := 101
		for j := 1; j <= 100; j++ {
			pos := positions[j]
			left := 0
			right := len(pos) - 1
			found := false
			for left <= right {
				mid := (left + right) / 2
				if pos[mid] >= start && pos[mid] <= end {
					found = true
					break
				} else if pos[mid] < start {
					left = mid + 1
				} else {
					right = mid - 1
				}
			}
			if found {
				if last != -1 {
					diff := j - last
					if diff < minDiff {
						minDiff = diff
					}
				}
				last = j
			}
		}
		if minDiff == 101 {
			result[i] = -1
		} else {
			result[i] = minDiff
		}
	}
	return result
}
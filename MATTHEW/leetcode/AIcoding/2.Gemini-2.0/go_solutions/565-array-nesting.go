func arrayNesting(nums []int) int {
	n := len(nums)
	visited := make([]bool, n)
	maxLen := 0
	for i := 0; i < n; i++ {
		if !visited[i] {
			count := 0
			curr := i
			for !visited[curr] {
				visited[curr] = true
				curr = nums[curr]
				count++
			}
			if count > maxLen {
				maxLen = count
			}
		}
	}
	return maxLen
}
func shortestSubarray(nums []int, k int) int {
	n := len(nums)
	length := n + 1
	for i := 0; i < n; i++ {
		orVal := 0
		for j := i; j < n; j++ {
			orVal |= nums[j]
			if orVal >= k {
				length = min(length, j-i+1)
				break
			}
		}
	}

	if length == n+1 {
		return -1
	}
	return length
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
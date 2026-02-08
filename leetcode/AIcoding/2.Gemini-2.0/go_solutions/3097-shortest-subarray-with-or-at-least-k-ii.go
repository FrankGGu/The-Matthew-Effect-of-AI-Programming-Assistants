func shortestSubarray(nums []int, k int) int {
	n := len(nums)
	ans := n + 1
	pre := make([]int, n+1)
	for i := 0; i < n; i++ {
		pre[i+1] = pre[i] | nums[i]
	}
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			if pre[j+1]|pre[i] == pre[j+1] && pre[j+1]|pre[i] >= k {
				ans = min(ans, j-i+1)
			}
		}
	}

	if ans == n+1 {
		return -1
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
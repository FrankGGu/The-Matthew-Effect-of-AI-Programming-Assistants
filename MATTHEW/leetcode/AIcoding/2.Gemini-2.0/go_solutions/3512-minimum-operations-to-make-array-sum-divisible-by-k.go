func minOperations(nums []int, k int) int {
	if k == 1 {
		return 0
	}
	n := len(nums)
	sum := 0
	for _, num := range nums {
		sum = (sum + num) % k
	}
	if sum == 0 {
		return 0
	}
	ans := n
	prefix := 0
	m := make(map[int]int)
	m[0] = -1
	for i := 0; i < n; i++ {
		prefix = (prefix + nums[i]) % k
		target := (prefix - sum + k) % k
		if j, ok := m[target]; ok {
			ans = min(ans, i-j)
		}
		m[prefix] = i
	}
	if ans == n {
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
func minSubarray(nums []int, p int) int {
	n := len(nums)
	need := 0
	for _, num := range nums {
		need = (need + num) % p
	}

	if need == 0 {
		return 0
	}

	ans := n
	prefix := map[int]int{0: -1}
	cur := 0
	for i, num := range nums {
		cur = (cur + num) % p
		target := (cur - need + p) % p
		if idx, ok := prefix[target]; ok {
			ans = min(ans, i-idx)
		}
		prefix[cur] = i
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
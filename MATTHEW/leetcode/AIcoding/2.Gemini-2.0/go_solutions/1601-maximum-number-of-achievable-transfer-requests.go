func maximumRequests(n int, requests [][]int) int {
	ans := 0
	m := len(requests)
	for mask := 0; mask < (1 << m); mask++ {
		cnt := 0
		balance := make([]int, n)
		for i := 0; i < m; i++ {
			if (mask>>i)&1 == 1 {
				cnt++
				balance[requests[i][0]]--
				balance[requests[i][1]]++
			}
		}
		ok := true
		for i := 0; i < n; i++ {
			if balance[i] != 0 {
				ok = false
				break
			}
		}
		if ok {
			ans = max(ans, cnt)
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
func numberOfWays(s string) int64 {
	n := len(s)
	zeros := make([]int, n)
	ones := make([]int, n)

	for i := 0; i < n; i++ {
		if i > 0 {
			zeros[i] = zeros[i-1]
			ones[i] = ones[i-1]
		}
		if s[i] == '0' {
			zeros[i]++
		} else {
			ones[i]++
		}
	}

	var ans int64
	for i := 1; i < n-1; i++ {
		if s[i] == '0' {
			ans += int64(ones[i-1]) * int64(ones[n-1] - ones[i])
		} else {
			ans += int64(zeros[i-1]) * int64(zeros[n-1] - zeros[i])
		}
	}

	return ans
}
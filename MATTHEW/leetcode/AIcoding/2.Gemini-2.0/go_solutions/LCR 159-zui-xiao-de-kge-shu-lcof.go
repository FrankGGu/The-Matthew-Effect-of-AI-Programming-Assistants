func canDistribute(quantities []int, n int) bool {
	cnt := make(map[int]int)
	for i := 0; i < n; i++ {
		cnt[quantities[i]]++
	}
	freq := []int{}
	for _, c := range cnt {
		freq = append(freq, c)
	}

	m := len(freq)
	sum := 0
	for _, f := range freq {
		sum += f
	}

	dp := make([]bool, sum+1)
	dp[0] = true

	for i := 0; i < m; i++ {
		for j := sum; j >= freq[i]; j-- {
			dp[j] = dp[j] || dp[j-freq[i]]
		}
	}

	return dp[sum/2]
}
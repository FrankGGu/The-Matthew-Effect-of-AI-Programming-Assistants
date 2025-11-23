const mod int = 1e9 + 7

func numberOfArrays(n int, k int, x int) int {
	if k > n-1 {
		return 0
	}
	if n == 1 {
		if k == 0 {
			return 1
		} else {
			return 0
		}
	}

	dp := make([][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, k+1)
	}

	if x == 1 {
		dp[0][0] = 0
	} else {
		dp[0][0] = 1
	}

	for i := 1; i < n; i++ {
		for j := 0; j <= k; j++ {
			if x == 1 {
				if j == 0 {
					dp[i][j] = (dp[i-1][j] * 0 + (2 - 1) * (sum(dp[i-1][j:]) % mod)) % mod
				} else {
					dp[i][j] = (dp[i-1][j-1] * 0 + (2 - 1) * (sum(dp[i-1][j:]) % mod)) % mod
				}
			} else {
				if j == 0 {
					dp[i][j] = (dp[i-1][j] * 1 + (2 - 1) * (sum(dp[i-1][j:]) % mod)) % mod
				} else {
					dp[i][j] = (dp[i-1][j-1] * 1 + (2 - 1) * (sum(dp[i-1][j:]) % mod)) % mod
				}
			}

			if x == 1 {
				if i == n-1 {
					if x == 1 {
						dp[i][j] = (dp[i-1][j] * 0 + (2 - 1) * (sum(dp[i-1][j:]) % mod)) % mod
					} else {
						dp[i][j] = (dp[i-1][j-1] + (2 - 1) * (sum(dp[i-1][j:]) % mod)) % mod
					}

					if j > 0 {
						dp[i][j] = dp[i-1][j-1]
					} else {
						dp[i][j] = 0
					}
				}
			} else {
				if i == n-1 {
					if x == 1 {
						if j > 0 {
							dp[i][j] = dp[i-1][j-1]
						} else {
							dp[i][j] = 0
						}
					} else {
						dp[i][j] = dp[i-1][j-1]
					}
				}
			}
			if x == 1{
				if i == n-1{
					if x == 1{
						if j > 0{
							dp[i][j] = dp[i-1][j-1] % mod
						}else{
							dp[i][j] = 0
						}
					}else{
						dp[i][j] = dp[i-1][j-1] % mod
					}

				}else{
					if j > 0{
						dp[i][j] = dp[i-1][j-1] % mod
					}else{
						dp[i][j] = 0
					}
				}
			}else{
				if i == n-1{
					if x == 1{
						if j > 0{
							dp[i][j] = dp[i-1][j-1] % mod
						}else{
							dp[i][j] = 0
						}
					}else{
						dp[i][j] = dp[i-1][j-1] % mod
					}

				}else{
					if j > 0{
						dp[i][j] = dp[i-1][j-1] % mod
					}else{
						dp[i][j] = 0
					}
				}
			}
		}
		if x == 1 {
			x = 2
		} else {
			x = 1
		}
	}

	return dp[n-1][k] % mod
}

func sum(arr []int) int {
	res := 0
	for _, v := range arr {
		res = (res + v) % mod
	}
	return res
}
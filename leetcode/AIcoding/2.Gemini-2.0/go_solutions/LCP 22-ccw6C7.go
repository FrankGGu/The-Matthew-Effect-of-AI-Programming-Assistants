func paintingPlan(n int, k int) int {
	if k < 0 || k > n*n {
		return 0
	}

	if n == 0 {
		if k == 0 {
			return 1
		}
		return 0
	}

	if n == 1 {
		if k == 0 || k == 1 {
			return 1
		}
		return 0
	}

	ans := 0
	for i := 0; i <= n; i++ {
		for j := 0; j <= n; j++ {
			if i*n+j*n-i*j == k {
				combI := combination(n, i)
				combJ := combination(n, j)
				ans += combI * combJ
			}
		}
	}
	return ans
}

func combination(n int, k int) int {
	if k < 0 || k > n {
		return 0
	}
	if k == 0 || k == n {
		return 1
	}
	if k > n/2 {
		k = n - k
	}
	res := 1
	for i := 1; i <= k; i++ {
		res = res * (n - i + 1) / i
	}
	return res
}
func sumOfTotalStrength(strength []int) int {
	n := len(strength)
	mod := 1000000007

	left := make([]int, n)
	stack := []int{}
	for i := 0; i < n; i++ {
		for len(stack) > 0 && strength[stack[len(stack)-1]] >= strength[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			left[i] = -1
		} else {
			left[i] = stack[len(stack)-1]
		}
		stack = append(stack, i)
	}

	right := make([]int, n)
	stack = []int{}
	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && strength[stack[len(stack)-1]] > strength[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			right[i] = n
		} else {
			right[i] = stack[len(stack)-1]
		}
		stack = append(stack, i)
	}

	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = (prefixSum[i] + strength[i]) % mod
	}

	prefixSum2 := make([]int, n+2)
	for i := 1; i <= n; i++ {
		prefixSum2[i+1] = (prefixSum2[i] + prefixSum[i]) % mod
	}

	ans := 0
	for i := 0; i < n; i++ {
		l := left[i]
		r := right[i]

		leftInterval := i - l
		rightInterval := r - i

		leftSum := ((prefixSum2[i+1] - prefixSum2[l+1])%mod - (int64(l)*(prefixSum[i+1]-prefixSum[l+1]))%mod)%mod
		if leftSum < 0 {
			leftSum += mod
		}

		rightSum := ((int64(r)*(prefixSum[r]-prefixSum[i+1]))%mod - (prefixSum2[r] - prefixSum2[i+1])%mod)%mod
		if rightSum < 0 {
			rightSum += mod
		}

		ans = (ans + int(int64(strength[i])*int64((int64(leftInterval)*int64(rightSum)%mod + int64(rightInterval)*int64(leftSum)%mod)%mod)%mod)) % mod
	}

	return ans
}
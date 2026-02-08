package main

func totalStrength(strength []int) int {
	mod := int64(1000000007)
	n := len(strength)
	left := make([]int, n)
	right := make([]int, n)
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
	prefix := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefix[i+1] = (prefix[i] + strength[i]) % mod
	}
	prefix2 := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefix2[i+1] = (prefix2[i] + prefix[i]) % mod
	}
	result := int64(0)
	for i := 0; i < n; i++ {
		l := left[i]
		r := right[i]
		ln := i - l
		rn := r - i
		sum1 := (prefix[i+1] - prefix[l+1]) % mod
		sum2 := (prefix[r] - prefix[i]) % mod
		a := (sum1 * int64(rn)) % mod
		b := (sum2 * int64(ln)) % mod
		total := (a + b) % mod
		result = (result + int64(strength[i])*total) % mod
	}
	return int(result)
}
func makeStringSorted(s string) int {
	n := len(s)
	arr := []int{}
	for i := 0; i < n; i++ {
		arr = append(arr, int(s[i]-'a'))
	}

	fact := make([]int, n+1)
	fact[0] = 1
	for i := 1; i <= n; i++ {
		fact[i] = (fact[i-1] * i) % 1000000007
	}

	pow := func(a, b int) int {
		res := 1
		a %= 1000000007
		for b > 0 {
			if b%2 == 1 {
				res = (res * a) % 1000000007
			}
			a = (a * a) % 1000000007
			b /= 2
		}
		return res
	}

	inv := func(n int) int {
		return pow(n, 1000000007-2)
	}

	ans := 0
	for i := 0; i < n; i++ {
		count := make([]int, 26)
		for j := i + 1; j < n; j++ {
			count[arr[j]]++
		}
		smaller := 0
		for j := 0; j < arr[i]; j++ {
			smaller += count[j]
		}

		denom := 1
		for j := 0; j < 26; j++ {
			denom = (denom * fact[count[j]]) % 1000000007
		}

		ans = (ans + (smaller * fact[n-i-1]) % 1000000007 * inv(denom) % 1000000007) % 1000000007
	}
	return ans
}
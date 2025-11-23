func countAnagrams(s string) int {
	words := strings.Split(s, " ")
	n := len(words)
	fact := make([]int, len(s)+1)
	fact[0] = 1
	mod := 1000000007
	for i := 1; i <= len(s); i++ {
		fact[i] = (fact[i-1] * i) % mod
	}

	pow := func(a, b int) int {
		res := 1
		a %= mod
		for b > 0 {
			if b%2 == 1 {
				res = (res * a) % mod
			}
			a = (a * a) % mod
			b /= 2
		}
		return res
	}

	inv := func(n int) int {
		return pow(n, mod-2)
	}

	ans := fact[len(s)]
	for _, word := range words {
		freq := make(map[rune]int)
		for _, r := range word {
			freq[r]++
		}
		ans = (ans * inv(fact[len(word)])) % mod
		for _, count := range freq {
			ans = (ans * fact[count]) % mod
		}
	}

	return ans
}
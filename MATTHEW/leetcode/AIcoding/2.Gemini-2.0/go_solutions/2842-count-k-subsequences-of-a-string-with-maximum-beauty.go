import "sort"

func countKSubsequencesWithMaxBeauty(s string, k int) int {
	freq := make([]int, 26)
	for _, char := range s {
		freq[char-'a']++
	}

	sort.Sort(sort.Reverse(sort.IntSlice(freq)))

	minFreq := freq[k-1]
	countMinFreq := 0
	for i := 0; i < 26; i++ {
		if freq[i] == minFreq {
			countMinFreq++
		}
	}

	countK := 0
	actualCount := 0
	for i := 0; i < 26; i++ {
		if freq[i] >= minFreq {
			if freq[i] == minFreq {
				actualCount++
			}
			countK++
		}
	}

	n := countK
	r := actualCount
	mod := 1000000007

	fact := make([]int, n+1)
	invFact := make([]int, n+1)

	fact[0] = 1
	for i := 1; i <= n; i++ {
		fact[i] = (fact[i-1] * i) % mod
	}

	invFact[n] = power(fact[n], mod-2, mod)
	for i := n - 1; i >= 0; i-- {
		invFact[i] = (invFact[i+1] * (i + 1)) % mod
	}

	combinations := (fact[n] * invFact[r]) % mod
	combinations = (combinations * invFact[n-r]) % mod

	return combinations
}

func power(base, exp, mod int) int {
	res := 1
	base %= mod
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % mod
		}
		base = (base * base) % mod
		exp /= 2
	}
	return res
}
package main

const MOD = 1e9 + 7
const MAXN = 3001

var fact [MAXN]int
var invFact [MAXN]int

func init() {
	fact[0] = 1
	invFact[0] = 1
	for i := 1; i < MAXN; i++ {
		fact[i] = (fact[i-1] * i) % MOD
		invFact[i] = pow(fact[i], MOD-2)
	}
}

func pow(base, exp int) int {
	res := 1
	base %= MOD
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % MOD
		}
		base = (base * base) % MOD
		exp /= 2
	}
	return res
}

func minOperationsToMakeStringSorted(s string) int {
	n := len(s)
	ans := 0
	freq := [26]int{}

	for i := 0; i < n; i++ {
		freq[s[i]-'a']++
	}

	for i := 0; i < n; i++ {
		charIdx := s[i] - 'a'

		smallerCount := 0
		for j := 0; j < int(charIdx); j++ {
			smallerCount += freq[j]
		}

		if smallerCount == 0 {
			freq[charIdx]--
			continue
		}

		term := fact[n-1-i]

		for j := 0; j < 26; j++ {
			term = (term * invFact[freq[j]]) % MOD
		}

		term = (term * smallerCount) % MOD

		ans = (ans + term) % MOD

		freq[charIdx]--
	}

	return ans
}
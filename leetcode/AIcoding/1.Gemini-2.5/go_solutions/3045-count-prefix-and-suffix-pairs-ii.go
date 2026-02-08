package main

const (
	MOD1    = 1_000_000_007
	MOD2    = 1_000_000_009
	BASE1   = 31
	BASE2   = 37
	MAX_LEN = 100 // Max length of a word
)

var (
	powBase1 [MAX_LEN + 1]int
	powBase2 [MAX_LEN + 1]int
)

func init() {
	powBase1[0] = 1
	powBase2[0] = 1
	for i := 1; i <= MAX_LEN; i++ {
		powBase1[i] = (powBase1[i-1] * BASE1) % MOD1
		powBase2[i] = (powBase2[i-1] * BASE2) % MOD2
	}
}

func countPrefixSuffixPairs(words []string) int64 {
	var totalPairs int64
	counts := make(map[[2]int]int)

	for _, w := range words {
		L := len(w)

		prefixHashes1 := make([]int, L+1)
		prefixHashes2 := make([]int, L+1)

		currentHash1 := 0
		currentHash2 := 0
		for k := 0; k < L; k++ {
			charVal := int(w[k]) - 'a' + 1
			currentHash1 = (currentHash1*BASE1 + charVal) % MOD1
			currentHash2 = (currentHash2*BASE2 + charVal) % MOD2
			prefixHashes1[k+1] = currentHash1
			prefixHashes2[k+1] = currentHash2
		}

		for k := 1; k <= L; k++ {
			pHash1 := prefixHashes1[k]
			pHash2 := prefixHashes2[k]

			// Calculate suffix hash of length k using the formula:
			// hash(S[L-k...L-1]) = (hash(S[0...L-1]) - hash(S[0...L-k-1]) * P^k) % M
			sHash1 := (prefixHashes1[L] - (prefixHashes1[L-k]*powBase1[k])%MOD1 + MOD1) % MOD1
			sHash2 := (prefixHashes2[L] - (prefixHashes2[L-k]*powBase2[k])%MOD2 + MOD2) % MOD2

			if pHash1 == sHash1 && pHash2 == sHash2 {
				if val, ok := counts[[2]int{pHash1, pHash2}]; ok {
					totalPairs += int64(val)
				}
			}
		}

		counts[[2]int{prefixHashes1[L], prefixHashes2[L]}]++
	}

	return totalPairs
}
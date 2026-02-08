package main

const (
	P1 = 31
	M1 = 1_000_000_007 // A large prime modulus
	P2 = 37
	M2 = 1_000_000_009 // Another large prime modulus
)

type HashPair struct {
	h1, h2 int64
}

func distinctEchoSubstrings(text string) int {
	n := len(text)
	if n < 2 {
		return 0
	}

	// Precompute prefix hashes and powers for the first hash function
	prefixHashes1 := make([]int64, n+1)
	powers1 := make([]int64, n+1)
	powers1[0] = 1
	for i := 1; i <= n; i++ {
		// Map 'a' to 1, 'b' to 2, etc. to avoid 0 values in hash calculation
		prefixHashes1[i] = (prefixHashes1[i-1]*P1 + int64(text[i-1]-'a'+1)) % M1
		powers1[i] = (powers1[i-1] * P1) % M1
	}

	// Precompute prefix hashes and powers for the second hash function
	prefixHashes2 := make([]int64, n+1)
	powers2 := make([]int64, n+1)
	powers2[0] = 1
	for i := 1; i <= n; i++ {
		prefixHashes2[i] = (prefixHashes2[i-1]*P2 + int64(text[i-1]-'a'+1)) % M2
		powers2[i] = (powers2[i-1] * P2) % M2
	}

	// Helper function to get hash for a substring [start, end) using hash function 1
	getHash1 := func(start, end int) int64 {
		length := end - start
		// (prefixHashes[end] - prefixHashes[start] * P^length) % M
		// Add M before modulo to handle potential negative results from subtraction
		hashVal := (prefixHashes1[end] - (prefixHashes1[start]*powers1[length])%M1 + M1) % M1
		return hashVal
	}

	// Helper function to get hash for a substring [start, end) using hash function 2
	getHash2 := func(start, end int) int64 {
		length := end - start
		hashVal := (prefixHashes2[end] - (prefixHashes2[start]*powers2[length])%M2 + M2) % M2
		return hashVal
	}

	// Use a map to store distinct echo substrings (represented by their hash pairs)
	distinctEchoes := make(map[HashPair]struct{})

	// Iterate through all possible starting positions i for an echo substring
	for i := 0; i < n; i++ {
		// Iterate through all possible half-lengths k
		// An echo substring has length 2*k. It must fit within the string.
		// So i + 2*k must be less than or equal to n.
		// k must be at least 1 (non-empty half).
		for k := 1; i+2*k <= n; k++ {
			// Calculate hashes for the first half: text[i : i+k]
			half1Hash1 := getHash1(i, i+k)
			half1Hash2 := getHash2(i, i+k)

			// Calculate hashes for the second half: text[i+k : i+2*k]
			half2Hash1 := getHash1(i+k, i+2*k)
			half2Hash2 := getHash2(i+k, i+2*k)

			// If both pairs of hashes match, we consider the two halves identical
			// and thus the full substring an echo substring.
			if half1Hash1 == half2Hash1 && half1Hash2 == half2Hash2 {
				// Get hashes for the full echo substring: text[i : i+2*k]
				fullEchoHash1 := getHash1(i, i+2*k)
				fullEchoHash2 := getHash2(i, i+2*k)
				distinctEchoes[HashPair{fullEchoHash1, fullEchoHash2}] = struct{}{}
			}
		}
	}

	return len(distinctEchoes)
}
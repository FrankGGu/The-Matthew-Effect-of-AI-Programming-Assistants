func longestDecomposition(text string) int {
	n := len(text)
	if n == 0 {
		return 0
	}

	// Rolling hash setup with two hash functions to reduce collision probability
	P1, M1 := int64(31), int64(1e9 + 7)
	P2, M2 := int64(37), int64(1e9 + 9)

	// Precompute powers of P
	P_pow1 := make([]int64, n+1)
	P_pow2 := make([]int64, n+1)
	P_pow1[0] = 1
	P_pow2[0] = 1
	for i := 1; i <= n; i++ {
		P_pow1[i] = (P_pow1[i-1] * P1) % M1
		P_pow2[i] = (P_pow2[i-1] * P2) % M2
	}

	// Precompute prefix hashes
	// h_f[k] stores hash of text[0...k-1]
	h_f1 := make([]int64, n+1)
	h_f2 := make([]int64, n+1)
	for i := 0; i < n; i++ {
		h_f1[i+1] = (h_f1[i]*P1 + int64(text[i]-'a'+1)) % M1
		h_f2[i+1] = (h_f2[i]*P2 + int64(text[i]-'a'+1)) % M2
	}

	// Helper function to get hash of substring text[start...end-1]
	// start is inclusive, end is exclusive
	getHash := func(start, end int, h_f []int64, P_pow []int64, M int64) int64 {
		length := end - start
		hashVal := (h_f[end] - (h_f[start]*P_pow[length])%M + M) % M
		return hashVal
	}

	count := 0
	left := 0
	right := n - 1

	for left <= right {
		foundMatch := false
		if left == right { // Single character remaining in the middle
			count++
			break
		}

		// Iterate 'i' from 1 to (current_length / 2)
		// current_length = right - left + 1
		// We need left + i <= right - i + 1 for the two chunks to not overlap
		// This means 2*i <= right - left + 1
		// So i <= (right - left + 1) / 2
		for i := 1; left+i <= right-i+1; i++ {
			// Get hash for prefix text[left : left + i]
			prefixHash1 := getHash(left, left+i, h_f1, P_pow1, M1)
			prefixHash2 := getHash(left, left+i, h_f2, P_pow2, M2)

			// Get hash for suffix text[right - i + 1 : right + 1]
			suffixHash1 := getHash(right-i+1, right+1, h_f1, P_pow1, M1)
			suffixHash2 := getHash(right-i+1, right+1, h_f2, P_pow2, M2)

			if prefixHash1 == suffixHash1 && prefixHash2 == suffixHash2 {
				count += 2
				left += i
				right -= i
				foundMatch = true
				break // Found the shortest match, move to the next iteration of the outer loop
			}
		}

		if !foundMatch { // No match found for any prefix/suffix pair
			count++ // The remaining middle part forms one chunk
			break
		}
	}

	return count
}
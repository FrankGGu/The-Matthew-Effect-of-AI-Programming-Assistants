func getHashValue(s string, power int, modulo int, k int, hashValue int) string {
	n := len(s)

	k64 := int64(k)
	power64 := int64(power)
	modulo64 := int64(modulo)
	hashValue64 := int64(hashValue)

	// Calculate power^(k-1) % modulo
	// This term is used to remove the leading character's contribution in the rolling hash.
	pPowKMinus1 := int64(1)
	for i := int64(0); i < k64-1; i++ {
		pPowKMinus1 = (pPowKMinus1 * power64) % modulo64
	}

	// Calculate the hash for the first substring s[0...k-1]
	// The hash function is H = (s[i]*p^(k-1) + s[i+1]*p^(k-2) + ... + s[i+k-1]*p^0) % m
	// This can be computed efficiently as:
	// H = (...((val(s[i]) * p + val(s[i+1])) * p + val(s[i+2])) * p + ...) * p + val(s[i+k-1])) % m
	currentHash := int64(0)
	for i := int64(0); i < k64; i++ {
		currentHash = (currentHash * power64) % modulo64
		currentHash = (currentHash + int64(s[i]-'a'+1)) % modulo64
	}

	// Store the starting index of the rightmost substring that matches hashValue
	resultIndex := -1
	if currentHash == hashValue64 {
		resultIndex = 0
	}

	// Roll the hash for subsequent substrings
	// i represents the starting index of the current window
	for i := int64(1); i <= int64(n)-k64; i++ {
		// Remove the contribution of the character s[i-1] (the character leaving the window)
		// The term to remove is val(s[i-1]) * p^(k-1)
		charToRemoveVal := int64(s[i-1] - 'a' + 1)
		termToRemove := (charToRemoveVal * pPowKMinus1) % modulo64
		currentHash = (currentHash - termToRemove + modulo64) % modulo64 // Add modulo64 to ensure positive result before final modulo

		// Shift the hash by multiplying by 'power'
		// This effectively multiplies all remaining terms by 'power', increasing their exponents
		currentHash = (currentHash * power64) % modulo64

		// Add the contribution of the new character s[i+k-1] (the character entering the window)
		// The new character is at the end of the window, so its power is p^0
		charToAddVal := int64(s[i+k-1] - 'a' + 1)
		currentHash = (currentHash + charToAddVal) % modulo64

		// If the current hash matches, update the result index.
		// We want the rightmost substring, so always update if a match is found.
		if currentHash == hashValue64 {
			resultIndex = int(i)
		}
	}

	// The problem guarantees that a substring with the given hash value exists.
	// So resultIndex will not be -1.
	return s[resultIndex : resultIndex+k]
}
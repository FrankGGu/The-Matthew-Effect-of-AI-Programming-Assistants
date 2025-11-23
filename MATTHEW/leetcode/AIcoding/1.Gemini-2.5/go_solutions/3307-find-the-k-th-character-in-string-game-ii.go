func findKthCharacter(n int, k int) byte {
	if n == 0 {
		return '0'
	}

	// Calculate the length of s_{n-1}.
	// The length of s_i is 2^(i+1) - 1.
	// So, the length of s_{n-1} is 2^((n-1)+1) - 1 = 2^n - 1.
	lenPrev := (1 << n) - 1

	if k <= lenPrev {
		// If k is in the first part (s_{n-1}), recurse with n-1 and k.
		return findKthCharacter(n-1, k)
	} else if k == lenPrev+1 {
		// If k is the middle character, which is always '1'.
		return '1'
	} else {
		// If k is in the third part (reverse(invert(s_{n-1}))).
		// First, find its corresponding 1-indexed position in the inverted string.
		// kPrime is the 1-indexed position relative to the start of the third part.
		kPrime := k - (lenPrev + 1)

		// The kPrime-th character in reverse(X) is the (len(X) - kPrime + 1)-th character in X.
		// Here, X is invert(s_{n-1}), and len(X) is lenPrev.
		originalPos := lenPrev - kPrime + 1

		// Recursively find the character in s_{n-1} at originalPos.
		charInSPrev := findKthCharacter(n-1, originalPos)

		// Invert the character.
		if charInSPrev == '0' {
			return '1'
		} else {
			return '0'
		}
	}
}
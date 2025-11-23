package main

func minimumTimeToRevertWord(word string, k int) int {
	n := len(word)

	// Z-algorithm implementation
	// z[i] is the length of the longest common prefix between word and word[i:]
	z := make([]int, n)
	if n > 0 {
		z[0] = n // By definition, the string matches itself for length n
	}

	l, r := 0, 0 // [l, r] is the current Z-box
	for i := 1; i < n; i++ {
		if i <= r {
			// If i is inside the current Z-box [l, r], we can use a value from a previous Z-value
			z[i] = min(r-i+1, z[i-l])
		}
		// Naive comparison to extend the Z-value if it's not fully determined by the Z-box
		for i+z[i] < n && word[z[i]] == word[i+z[i]] {
			z[i]++
		}
		// If the current Z-value extends beyond r, update the Z-box
		if i+z[i]-1 > r {
			l = i
			r = i + z[i] - 1
		}
	}

	// Iterate through possible number of operations (x)
	// We are looking for the smallest x such that word[x*k:] is a prefix of word
	for x := 1; ; x++ {
		startIdx := x * k

		// If startIdx is exactly n, it means we've removed the entire word.
		// The remaining part is an empty string. An empty string is a prefix of itself (length 0).
		// This is always a match.
		if startIdx == n {
			return x
		}

		// If startIdx exceeds n, it means we've removed more characters than available.
		// This case is implicitly covered by the problem guarantee that a solution exists
		// and will be found when startIdx <= n.
		// The largest possible startIdx we need to consider is n.

		// The required length for the match is n - startIdx.
		// We need word[startIdx:] to be equal to word[:n-startIdx].
		// This is true if Z[startIdx] (length of common prefix between word and word[startIdx:])
		// is at least requiredLen.
		requiredLen := n - startIdx
		if z[startIdx] >= requiredLen {
			return x
		}
	}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
import (
	"math"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minCharacters(a string, b string) int {
	lenA := len(a)
	lenB := len(b)

	freqA := make([]int, 26)
	freqB := make([]int, 26)

	for _, char := range a {
		freqA[char-'a']++
	}
	for _, char := range b {
		freqB[char-'a']++
	}

	prefixA := make([]int, 26)
	prefixB := make([]int, 26)
	prefixA[0] = freqA[0]
	prefixB[0] = freqB[0]
	for i := 1; i < 26; i++ {
		prefixA[i] = prefixA[i-1] + freqA[i]
		prefixB[i] = prefixB[i-1] + freqB[i]
	}

	ans := math.MaxInt32

	// Condition 1: Every character in a is strictly less than every character in b.
	// This means there exists some character 'x' (from 'a' to 'y')
	// such that all characters in 'a' are <= 'x' and all characters in 'b' are > 'x'.
	// Iterate k from 0 to 24 (representing 'a' to 'y').
	for k := 0; k < 25; k++ {
		// Cost for 'a': characters in 'a' that are > 'a'+k must be changed.
		// These are lenA - (count of chars in 'a' <= 'a'+k) = lenA - prefixA[k].
		costA := lenA - prefixA[k]

		// Cost for 'b': characters in 'b' that are <= 'a'+k must be changed.
		// These are (count of chars in 'b' <= 'a'+k) = prefixB[k].
		costB := prefixB[k]

		ans = min(ans, costA+costB)
	}

	// Condition 2: Every character in b is strictly less than every character in a.
	// Symmetric to Condition 1.
	// This means there exists some character 'x' (from 'a' to 'y')
	// such that all characters in 'b' are <= 'x' and all characters in 'a' are > 'x'.
	// Iterate k from 0 to 24 (representing 'a' to 'y').
	for k := 0; k < 25; k++ {
		// Cost for 'b': characters in 'b' that are > 'a'+k must be changed.
		costB := lenB - prefixB[k]

		// Cost for 'a': characters in 'a' that are <= 'a'+k must be changed.
		costA := prefixA[k]

		ans = min(ans, costA+costB)
	}

	// Condition 3: Every character in a and every character in b are the same character.
	// This means all characters in 'a' become 'x' and all characters in 'b' become 'x'.
	// Iterate k from 0 to 25 (representing 'a' to 'z').
	for k := 0; k < 26; k++ {
		// Cost for 'a': characters in 'a' that are not 'a'+k must be changed.
		costA := lenA - freqA[k]

		// Cost for 'b': characters in 'b' that are not 'a'+k must be changed.
		costB := lenB - freqB[k]

		ans = min(ans, costA+costB)
	}

	return ans
}
import (
	"strings"
)

func findLexicographicallyLargestString(s string, k int) string {
	counts := make([]int, 26)
	for _, char := range s {
		counts[char-'a']++
	}

	var sb strings.Builder
	for i := 25; i >= 0; i-- { // Iterate from 'z' down to 'a'
		char := byte('a' + i)

		// Determine how many of this character we can use
		numToUse := counts[i]
		if numToUse > k {
			numToUse = k
		}

		for j := 0; j < numToUse; j++ {
			sb.WriteByte(char)
		}
		k -= numToUse

		if k == 0 {
			break
		}
	}

	return sb.String()
}
import "math"

func longestGoodSubsequence(s string, k int) int {
	dp := make([]int, 26) // dp[char_code] stores the maximum length of a good subsequence ending with char_code
	maxLength := 0

	for i := 0; i < len(s); i++ {
		currentCharCode := int(s[i] - 'a')

		currentMaxLen := 1 // A single character itself forms a good subsequence of length 1

		// Iterate through all possible previous character codes (0-25)
		for prevCharCode := 0; prevCharCode < 26; prevCharCode++ {
			// Only consider if there's an existing good subsequence ending with prevCharCode
			if dp[prevCharCode] > 0 {
				// Check if the absolute difference between current and previous character codes is at most k
				if int(math.Abs(float64(currentCharCode-prevCharCode))) <= k {
					// If it's a good pair, try to extend the subsequence ending at prevCharCode
					currentMaxLen = int(math.Max(float64(currentMaxLen), float64(dp[prevCharCode]+1)))
				}
			}
		}

		// Update dp for the current character.
		// We take the maximum because multiple paths might lead to a subsequence ending with currentCharCode,
		// and we want the longest one.
		dp[currentCharCode] = int(math.Max(float64(dp[currentCharCode]), float64(currentMaxLen)))

		// Update the overall maximum length found so far
		maxLength = int(math.Max(float64(maxLength), float64(dp[currentCharCode])))
	}

	return maxLength
}
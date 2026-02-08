package main

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func substringXorQueries(s string, queries [][]int) []int {
	// maxRelevantValue defines the upper bound for target values.
	// Since first_i, second_i <= 10^9, their XOR sum (target) will be <= 2^30 - 1.
	// A 30-bit number can represent values up to 2^30 - 1.
	// The value 2^30 itself is 1073741824, which is greater than 10^9.
	// So, any number >= 2^30 is too large to be a target.
	// We only need to consider substrings that form numbers strictly less than 2^30.
	// The longest binary string that forms a number < 2^30 is 30 bits long (e.g., all '1's).
	// Therefore, we only need to extract substrings of length up to 30.
	maxRelevantValue := 1 << 30 // This is 2^30

	possibleValues := make(map[int]struct{})
	n := len(s)

	for i := 0; i < n; i++ {
		currentVal := 0
		// If the current character is '0', then '0' itself is a possible value.
		// This handles cases like s="0", s="01", s="101" (substring "0" at index 1).
		if s[i] == '0' {
			possibleValues[0] = struct{}{}
		}

		// Iterate for substrings starting at i.
		// The length of the substring s[i...j] is (j - i + 1).
		// We consider substrings of length up to 30. So, j - i + 1 <= 30  =>  j <= i + 29.
		// The loop for j should go up to `min(i + 29, n - 1)`.
		// Or, equivalently, `j < min(i + 30, n)`.
		for j := i; j < min(i+30, n); j++ {
			digit := int(s[j] - '0')

			// Update currentVal by appending the new digit.
			// This correctly handles leading zeros (e.g., "01" becomes 1).
			currentVal = currentVal*2 + digit

			// If currentVal becomes greater than or equal to maxRelevantValue,
			// it means this number is too large to be a target.
			// Any further extension of this substring will also result in a number
			// that is too large, so we can break from this inner loop.
			if currentVal >= maxRelevantValue {
				break
			}
			possibleValues[currentVal] = struct{}{}
		}
	}

	ans := make([]int, len(queries))
	for i, query := range queries {
		first := query[0]
		second := query[1]
		target := first ^ second

		if _, found := possibleValues[target]; found {
			ans[i] = target
		} else {
			ans[i] = -1
		}
	}

	return ans
}
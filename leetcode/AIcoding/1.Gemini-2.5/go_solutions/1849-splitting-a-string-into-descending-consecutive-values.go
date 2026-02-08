import (
	"strconv"
)

func canSplit(s string) bool {
	var dfs func(index int, prevVal int64, count int) bool
	dfs = func(index int, prevVal int64, count int) bool {
		// Base case: If we've reached the end of the string
		// and have made at least two splits, it's a valid split.
		if index == len(s) {
			return count >= 2
		}

		// Iterate to form the current number
		for i := index; i < len(s); i++ {
			currentNumStr := s[index : i+1]

			currVal, err := strconv.ParseInt(currentNumStr, 10, 64)
			if err != nil {
				// If parsing fails (e.g., overflow for int64),
				// this number is too large. Any longer number formed by
				// adding more digits will also be too large.
				// So, we break from this inner loop.
				break
			}

			if count == 0 { // This is the first number
				// Try to split the rest of the string starting from i+1
				if dfs(i+1, currVal, 1) {
					return true
				}
			} else { // This is a subsequent number
				// It must be exactly one less than the previous value.
				if currVal == prevVal-1 {
					// Recursively call for the next part
					if dfs(i+1, currVal, count+1) {
						return true
					}
				}
				// Optimization: If current number is already greater than (prevVal - 1),
				// then any further digits will only make it larger, so it will never equal (prevVal - 1).
				// We can prune this branch.
				if currVal > prevVal-1 {
					break
				}
			}
		}
		return false // No valid split found from this index
	}

	// Iterate through all possible first numbers
	// The first number can be any length from 1 up to len(s)-1
	// (to ensure there's at least one character left for the second number).
	for i := 0; i < len(s)-1; i++ {
		firstNumStr := s[0 : i+1]

		firstVal, err := strconv.ParseInt(firstNumStr, 10, 64)
		if err != nil {
			// If parsing fails (e.g., overflow), then this first number is too large.
			// Any longer first number will also be too large.
			// So, we can stop trying longer first numbers.
			break
		}

		// Start DFS from the next index (i+1), with the first number's value, and count 1.
		if dfs(i+1, firstVal, 1) {
			return true
		}
	}

	return false
}
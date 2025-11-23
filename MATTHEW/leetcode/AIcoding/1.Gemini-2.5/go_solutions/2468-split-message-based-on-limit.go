package main

import (
	"strconv"
)

func splitMessage(message string, limit int) []string {
	// Smallest possible suffix is "(1/1)", which has length 5.
	// If limit is less than 5, no message can be split.
	if limit < 5 {
		return []string{}
	}

	m := len(message)

	// sumDigitsI calculates the sum of the number of digits for integers from 1 to n.
	// For example, sumDigitsI(10) = len("1") + ... + len("9") + len("10") = 9*1 + 1*2 = 11.
	sumDigitsI := func(n int) int {
		sum := 0
		powerOf10 := 1
		digits := 1
		for {
			// Numbers with 'digits' digits start from powerOf10 (e.g., 1, 10, 100)
			// and go up to (powerOf10 * 10 - 1) (e.g., 9, 99, 999).
			// We are interested in numbers up to 'n'.
			upperBoundForDigits := powerOf10*10 - 1

			currentUpper := upperBoundForDigits
			if currentUpper > n {
				currentUpper = n
			}

			// Count of numbers with 'digits' digits in the range [powerOf10, currentUpper].
			// This range is valid only if powerOf10 <= currentUpper.
			count := currentUpper - powerOf10 + 1
			if count <= 0 { // No numbers in this range, or we've processed all numbers up to n.
				break
			}

			sum += digits * count

			if currentUpper == n { // We've processed all numbers up to n.
				break
			}

			powerOf10 *= 10
			digits++
		}
		return sum
	}

	// Iterate through possible total number of parts 'n'.
	// The maximum possible value for 'n' can be roughly 'm' (if each part holds 1 character)
	// or up to around 2 * 10^5 (e.g., if m=10^5 and limit=6, each part has 1 char content).
	// We use a safe upper bound for 'n'.
	for n := 1; n <= m+1 && n <= 200000; n++ {
		// Calculate the number of digits for 'n' (the total parts count 'y' in "(x/y)").
		nStr := strconv.Itoa(n)
		digitsN := len(nStr)

		// The maximum suffix length for any part 'i' (where 1 <= i <= n) occurs when 'i' also has 'digitsN' digits.
		// So, maxSuffixLenForThisN = len(strconv.Itoa(i_max_digits)) + len(strconv.Itoa(n)) + 3
		// = digitsN + digitsN + 3.
		// If the limit is less than this, it's impossible to form even the longest suffix.
		// In this case, this 'n' and any larger 'n' (which would have equal or more digits for 'n' and 'i')
		// are also impossible. So, we return an empty slice.
		if limit < digitsN+digitsN+3 {
			return []string{}
		}

		// Calculate the total content length available across all 'n' parts.
		// For each part 'i', the content length is `limit - (len(strconv.Itoa(i)) + digitsN + 3)`.
		// Summing this from i=1 to n:
		// `sum_{i=1 to n} (limit - digitsN - 3 - len(strconv.Itoa(i)))`
		// `= n * (limit - digitsN - 3) - sum_{i=1 to n} len(strconv.Itoa(i))`
		// This formula is valid because we've already checked that `limit` is large enough
		// to ensure `limit - (len(strconv.Itoa(i)) + digitsN + 3)` will be non-negative for all `i`.
		totalContentAvailable := int64(n)*(int64(limit-digitsN-3)) - int64(sumDigitsI(n))

		// If the total available content is enough to hold the entire message,
		// then this 'n' is the smallest possible number of parts.
		if totalContentAvailable >= int64(m) {
			result := make([]string, n)
			currentMsgIdx := 0
			for i := 1; i <= n; i++ {
				iStr := strconv.Itoa(i)
				suffix := "(" + iStr + "/" + nStr + ")"
				contentLen := limit - len(suffix)

				partContent := ""
				if currentMsgIdx < m { // Ensure we don't go out of bounds for the message string
					endIdx := min(currentMsgIdx+contentLen, m)
					partContent = message[currentMsgIdx:endIdx]
					currentMsgIdx = endIdx
				}
				result[i-1] = partContent + suffix
			}
			return result
		}
	}

	// If no suitable 'n' is found after checking all possibilities, return an empty slice.
	return []string{}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
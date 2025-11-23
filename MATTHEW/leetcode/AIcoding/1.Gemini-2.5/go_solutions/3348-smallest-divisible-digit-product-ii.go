import (
	"sort"
	"strconv"
)

func smallestFactorization(n int) int {
	if n == 1 {
		return 1
	}

	digits := []byte{}

	// Iterate digits from 9 down to 2
	for d := 9; d >= 2; d-- {
		// As long as n is divisible by d, divide n by d and add d to our digits list
		for n%d == 0 {
			digits = append(digits, byte('0'+d))
			n /= d
		}
	}

	// If n is still greater than 1, it means n has prime factors greater than 9
	// (or is a prime itself greater than 9), so no solution exists.
	if n > 1 {
		return -1
	}

	// Sort the collected digits in ascending order to form the smallest number
	sort.Slice(digits, func(i, j int) bool {
		return digits[i] < digits[j]
	})

	// Convert the slice of bytes (digits) to a string
	resStr := string(digits)

	// Convert the string to an int64 to check for overflow against 2^31 - 1
	val, err := strconv.ParseInt(resStr, 10, 64)

	// Check for parsing error or if the value exceeds the maximum allowed int32 value
	maxInt32 := int64(2147483647) // 2^31 - 1
	if err != nil || val > maxInt32 {
		return -1
	}

	return int(val)
}
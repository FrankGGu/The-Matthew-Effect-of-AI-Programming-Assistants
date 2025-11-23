package main

import (
	"strconv"
	"strings"
)

func fractionToDecimal(numerator int, denominator int) string {
	if numerator == 0 {
		return "0"
	}

	var sb strings.Builder

	// Determine the sign of the result
	if (numerator < 0 && denominator > 0) || (numerator > 0 && denominator < 0) {
		sb.WriteByte('-')
	}

	// Convert to int64 and take absolute values to handle potential overflow
	// when numerator is math.MinInt32 and to simplify calculations.
	num := int64(numerator)
	den := int64(denominator)

	if num < 0 {
		num = -num
	}
	if den < 0 {
		den = -den
	}

	// Append the integer part
	sb.WriteString(strconv.FormatInt(num/den, 10))

	remainder := num % den
	if remainder == 0 {
		return sb.String()
	}

	// Append the decimal point
	sb.WriteByte('.')

	// Map to store remainder -> index in the string builder where this remainder first appeared.
	// This helps detect repeating decimals.
	remainderMap := make(map[int64]int)

	for remainder != 0 {
		if idx, found := remainderMap[remainder]; found {
			// A cycle is detected. Insert parentheses.
			result := sb.String()
			return result[:idx] + "(" + result[idx:] + ")"
		}

		// Store the current remainder and its position in the string builder.
		// sb.Len() gives the current length, which is the index where the next digit will be placed.
		remainderMap[remainder] = sb.Len()

		// Multiply remainder by 10 to get the next decimal digit
		remainder *= 10
		digit := remainder / den
		sb.WriteString(strconv.FormatInt(digit, 10))
		remainder %= den
	}

	return sb.String()
}
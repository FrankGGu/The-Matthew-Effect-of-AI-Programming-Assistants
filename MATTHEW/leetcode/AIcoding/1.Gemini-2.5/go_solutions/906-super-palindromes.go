package main

import (
	"strconv"
)

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func isPalindrome(n int64) bool {
	if n < 0 {
		return false
	}
	if n < 10 { // Single digit numbers are palindromes
		return true
	}
	original := n
	reversed := int64(0)
	for n > 0 {
		digit := n % 10
		reversed = reversed*10 + digit
		n /= 10
	}
	return original == reversed
}

func superpalindromesInRange(L string, R string) int {
	L_val, _ := strconv.ParseInt(L, 10, 64)
	R_val, _ := strconv.ParseInt(R, 10, 64)

	count := 0

	// We are looking for numbers x such that x is a palindrome and x*x is a palindrome.
	// The range for x*x is [L_val, R_val].
	// The maximum value for R_val is 10^18.
	// So, x*x <= 10^18, which implies x <= sqrt(10^18) = 10^9.
	// We generate palindromes x by constructing them from their first half `i`.
	// The first half `i` can be up to 5 digits (e.g., 99999).
	// If i = 99999, an odd-length palindrome x is 999999999 (9 digits).
	// Its square is 999999998000000001, which fits in int64 and is <= 10^18.
	// If i = 100000, an odd-length palindrome x would be 10000000001 (11 digits), which is > 10^9.
	// Therefore, iterating `i` from 1 up to 100,000 (exclusive) is sufficient to cover all relevant `x`.
	for i := 1; i < 100000; i++ {
		s := strconv.Itoa(i)

		// Case 1: x is an odd-length palindrome (e.g., if i="123", x="12321")
		// Constructed by `s` + `reverse(s without its last digit)`
		x_str_odd := s + reverseString(s[:len(s)-1])
		x_odd, _ := strconv.ParseInt(x_str_odd, 10, 64)

		// Optimization: If x itself exceeds 10^9, its square will exceed 10^18 (max R_val).
		// Since `i` is increasing, any further `x_odd` and `x_even` will also be too large.
		if x_odd > 1000000000 { // 10^9
			break
		}

		x_sq_odd := x_odd * x_odd
		// Check if x_sq_odd is within the range [L_val, R_val] and is a palindrome.
		if x_sq_odd > R_val {
			// If x_sq_odd exceeds R_val, then for current `i`, `x_sq_even` (if generated) will also exceed `R_val`.
			// And for all subsequent `i`, `x_sq_odd` and `x_sq_even` will exceed `R_val`.
			// So we can break the loop.
			break
		}
		if x_sq_odd >= L_val && isPalindrome(x_sq_odd) {
			count++
		}

		// Case 2: x is an even-length palindrome (e.g., if i="123", x="123321")
		// Constructed by `s` + `reverse(s)`
		x_str_even := s + reverseString(s)
		x_even, _ := strconv.ParseInt(x_str_even, 10, 64)

		// Optimization: If x itself exceeds 10^9, its square will exceed 10^18 (max R_val).
		if x_even > 1000000000 { // 10^9
			// We cannot break the loop for `i` here, because `x_odd` for the next `i` might still be valid.
			// Just skip this `x_even` and continue to the next `i`.
			continue
		}

		x_sq_even := x_even * x_even
		// Check if x_sq_even is within the range [L_val, R_val] and is a palindrome.
		if x_sq_even > R_val {
			// Similar to the `x_even > 10^9` case, we cannot break the `i` loop here.
			// Just skip this `x_sq_even` and continue to the next `i`.
			continue
		}
		if x_sq_even >= L_val && isPalindrome(x_sq_even) {
			count++
		}
	}

	return count
}
package main

import (
	"math"
	"strconv"
)

func reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}

func buildPalindrome(prefix string, isOddLength bool) string {
	if isOddLength {
		// For odd length, the last digit of the prefix is the middle digit, so it's not reversed.
		return prefix + reverse(prefix[:len(prefix)-1])
	}
	// For even length, the prefix is fully reversed and appended.
	return prefix + reverse(prefix)
}

func nearestPalindromic(n string) string {
	numN, _ := strconv.ParseInt(n, 10, 64)
	l := len(n)

	candidates := make(map[int64]bool)

	// Candidate 1: Palindrome with length l-1 (e.g., for n="100", this is 99)
	// This is a string of (l-1) nines.
	if l > 1 {
		candidates[int64(math.Pow10(l-1))-1] = true
	}

	// Candidate 2: Palindrome with length l+1 (e.g., for n="99", this is 101)
	// This is 1 followed by (l-1) zeros, then 1.
	candidates[int64(math.Pow10(l))+1] = true

	// Candidate 3: Palindromes based on the prefix of n
	// Take the first half of n (including the middle digit if l is odd)
	halfLen := (l + 1) / 2
	prefixStr := n[:halfLen]
	prefixNum, _ := strconv.ParseInt(prefixStr, 10, 64)

	// Generate palindromes using prefix-1, prefix, and prefix+1
	for i := -1; i <= 1; i++ {
		newPrefixNum := prefixNum + int64(i)

		// If newPrefixNum becomes 0 and original length `l` is greater than 1,
		// the resulting palindrome would be like "00", "000", which are not valid positive numbers.
		// The only valid case for a "0" palindrome is if n="1" and the candidate is "0".
		if newPrefixNum == 0 && l > 1 {
			continue
		}

		palStr := buildPalindrome(strconv.FormatInt(newPrefixNum, 10), l%2 == 1)

		// Only consider candidates that have the same length as n (l) from this method.
		// Candidates with different lengths are handled by the `Pow10` cases.
		if len(palStr) == l {
			cand, _ := strconv.ParseInt(palStr, 10, 64)
			candidates[cand] = true
		}
	}

	// Remove n itself from candidates if it's a palindrome
	// (The problem asks for the *closest* palindrome, not including n itself)
	delete(candidates, numN)

	minDiff := int64(math.MaxInt64)
	var result int64

	for cand := range candidates {
		diff := int64(math.Abs(float64(cand - numN)))
		if diff < minDiff {
			minDiff = diff
			result = cand
		} else if diff == minDiff {
			if cand < result {
				result = cand
			}
		}
	}

	return strconv.FormatInt(result, 10)
}
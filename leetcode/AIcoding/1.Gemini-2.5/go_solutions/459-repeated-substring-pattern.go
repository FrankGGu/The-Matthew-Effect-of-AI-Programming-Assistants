import "strings"

func repeatedSubstringPattern(s string) bool {
	n := len(s)
	if n == 0 {
		return false
	}

	// The core idea:
	// If a string 's' is composed of repeating a substring 'p' multiple times (e.g., s = p + p + ... + p),
	// then 's' must be present in the string 's + s' after removing its first and last characters.
	//
	// Let s = p * k, where k >= 2 (multiple copies).
	// Consider temp = s + s. This is (p * k) + (p * k).
	// Now consider temp[1 : len(temp)-1]. This effectively removes the first character of the first 's'
	// and the last character of the second 's'.
	//
	// Example: s = "abab", p = "ab", k = 2.
	// temp = "abababab".
	// temp[1:7] = "bababa".
	// "bababa" contains "abab". So, true.
	//
	// Example: s = "abcabc", p = "abc", k = 2.
	// temp = "abcabcabcabc".
	// temp[1:11] = "bcabcabcab".
	// "bcabcabcab" contains "abcabc". So, true.
	//
	// Example: s = "aba", not a repeating pattern.
	// temp = "abaaba".
	// temp[1:5] = "baab".
	// "baab" does not contain "aba". So, false.
	//
	// This approach works because if s = p * k (k >= 2), then s is essentially a cyclic shift of itself.
	// By creating (s+s) and removing the first/last characters, we create a string that will contain
	// all possible cyclic shifts of 's' (except 's' itself, which is not a proper shift for repetition).
	// If 's' is a repeated pattern, one of these shifts will align perfectly to reveal 's' within the string.
	// The string s itself will be found starting at index len(p)-1 within temp[1:len(temp)-1].
	// This method correctly handles cases where k=1 (s is not a repeated pattern) because
	// s will not be found in temp[1:len(temp)-1].
	//
	// Time complexity: O(N) due to string concatenation and strings.Contains (which can be implemented with KMP).
	// Space complexity: O(N) for the temporary string.

	temp := s + s
	// Check if 's' is a substring of 'temp' excluding its first and last characters.
	// The slice `temp[1:len(temp)-1]` creates a new string.
	return strings.Contains(temp[1:len(temp)-1], s)
}
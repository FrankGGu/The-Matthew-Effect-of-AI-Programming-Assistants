package main

import "fmt"

func solve() {
	var s string
	var k int
	fmt.Scan(&s, &k)

	n := len(s)
	if n == 0 {
		fmt.Println(0)
		return
	}

	// Calculate the Longest Proper Prefix which is also a Suffix (LPS) array using KMP algorithm.
	// pi[j] stores the length of the longest proper prefix of s[0...j] that is also a suffix of s[0...j].
	pi := make([]int, n)
	pi[0] = 0
	for j := 1; j < n; j++ {
		i := pi[j-1]
		for i > 0 && s[j] != s[i] {
			i = pi[i-1]
		}
		if s[j] == s[i] {
			i++
		}
		pi[j] = i
	}

	// The problem asks for the minimum operations to make the string empty.
	// An operation removes a prefix of length `l` (1 <= l <= k) and appends it to the end
	// if the string is not empty after removal.
	// This means the string length never changes unless the entire string is removed.
	// The only way to make the string empty is to remove a prefix of length equal to
	// the current string's length. This is only possible if current_length <= k.
	//
	// The problem is effectively asking for the minimum number of operations to reach
	// a state where the string `s` has been "processed" enough times such that
	// the remaining part can be cleared.
	//
	// This is equivalent to finding the smallest `i` (number of characters to remove)
	// such that `s[i:]` is a prefix of `s`.
	// This `i` is `N - pi[N-1]`, where `pi[N-1]` is the length of the longest
	// proper prefix of `s` that is also a suffix of `s`.
	//
	// If `s[N-pi[N-1]:]` is a prefix of `s`, it means that after removing
	// `N - pi[N-1]` characters, the remaining string `s[N-pi[N-1]:]` is identical
	// to `s[0...pi[N-1]-1]`, which is a prefix of `s`.
	//
	// The number of characters we effectively need to remove is `N - pi[N-1]`.
	// Let this be `charsToRemove`.
	// Each operation can remove up to `k` characters.
	// So, the minimum number of operations is `ceil(charsToRemove / k)`.

	charsToRemove := n - pi[n-1]

	// Calculate ceil(charsToRemove / k) using integer division
	operations := (charsToRemove + k - 1) / k

	fmt.Println(operations)
}

func main() {
	solve()
}
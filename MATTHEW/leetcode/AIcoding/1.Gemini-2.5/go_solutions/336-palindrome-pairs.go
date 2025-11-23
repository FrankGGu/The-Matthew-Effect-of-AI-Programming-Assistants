package main

import (
	"strings"
)

type TrieNode struct {
	children map[rune]*TrieNode
	wordIdx  int // Stores the original index of the word whose reverse ends at this node
	// Stores indices of words `j` such that `reverse(words[j])` has a suffix (from current node to end) that is a palindrome.
	// This means `words[j]` has a prefix (from root to current node, representing `reverse(words[j][0:k])`) and a palindrome suffix (`words[j][k:]`).
	palindromeSuffixesAtNode []int
}

func newTrieNode() *TrieNode {
	return &TrieNode{
		children: make(map[rune]*TrieNode),
		wordIdx:  -1,
	}
}

func isPalindrome(s string) bool {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		if s[i] != s[j] {
			return false
		}
	}
	return true
}

func reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func palindromePairs(words []string) [][]int {
	root := newTrieNode()

	// Build Trie with reversed words
	for i, word := range words {
		curr := root
		reversedWord := reverse(word)

		for k := 0; k < len(reversedWord); k++ {
			// If the suffix of `reversedWord` starting from `k` is a palindrome,
			// it means `reversedWord[k:]` is a palindrome.
			// The current node `curr` represents `reversedWord[0:k]`.
			// So `curr` is a node corresponding to a prefix of `reversedWord`.
			// This condition checks for pairs `[j, i]` where `words[j]` is `reversedWord[0:k]`
			// and `words[i]` has `reversedWord[k:]` as a palindrome suffix.
			// This forms `words[j] + words[i]` as `reversedWord[0:k] + reverse(reversedWord[0:k]) + reversedWord[k:]` (not quite).
			// Correct interpretation: `curr.palindromeSuffixesAtNode` stores indices `i` where `reverse(words[i])` has a suffix `reversedWord[k:]` that is a palindrome.
			// And the path to `curr` is `reversedWord[0:k]`.
			// This means `words[i]` has `reverse(reversedWord[0:k])` as a suffix, and `reverse(reversedWord[k:])` as a prefix which is a palindrome.
			// This is for `words[j] + words[i]` where `words[j]` is `reverse(reversedWord[0:k])` and `words[i]` is `reverse(reversedWord[k:])` + `reverse(reversedWord[0:k])`.
			// This is Case 3: `words[i]` is longer than `words[j]`. `words[i] = palindrome_prefix + reverse(words[j])`.
			// The `isPalindrome(reversedWord[k:])` check is for the suffix of the reversed word (which corresponds to a prefix of the original word).
			// If `reversedWord[k:]` is a palindrome, it means `words[i][0:len(words[i])-k]` is a palindrome.
			// So, if we find `words[j]` that is `reverse(words[i][len(words[i])-k:])`, then `words[j] + words[i]` is a palindrome.
			// This is for `[j, i]` where `words[i]` is split into `P` (palindrome) and `S`. `words[j]` is `reverse(S)`.
			// Here, `P` is `words[i][0:len(words[i])-k]`, `S` is `words[i][len(words[i])-k:]`.
			// `reversedWord[k:]` is `reverse(words[i][0:len(words[i])-k])`.
			// If `isPalindrome(reversedWord[k:])` is true, then `words[i][0:len(words[i])-k]` is a palindrome.
			// So, if `words[j]` matches `reverse(words[i][len(words[i])-k:])`, then `words[j] + words[i]` is a palindrome.
			// This is the `palindromeSuffixesAtNode` for the current `curr` node.
			if isPalindrome(reversedWord[k:]) {
				curr.palindromeSuffixesAtNode = append(curr.palindromeSuffixesAtNode, i)
			}

			char := rune(reversedWord[k])
			if _, ok := curr.children[char]; !ok {
				curr.children[char] = newTrieNode()
			}
			curr = curr.children[char]
		}
		curr.wordIdx = i
		// The entire `reversedWord` is a suffix of itself. If `reversedWord` is a palindrome (i.e., `word` is a palindrome),
		// then `i` should be added. This also covers the empty string case.
		curr.palindromeSuffixesAtNode = append(curr.palindromeSuffixesAtNode, i)
	}

	results := [][]int{}

	// Search for pairs
	for i, word := range words {
		curr := root
		for k := 0; k < len(word); k++ {
			// Case 1: `words[j] + words[i]` is a palindrome, where `words[j]` is shorter than `words[i]`.
			// `words[i] = prefix + palindrome_suffix`. `words[j] = reverse(prefix)`.
			// We are traversing `words[i]` (original word).
			// `curr.wordIdx` is `j` such that `reverse(words[j])` ends at `curr`.
			// So `reverse(words[j])` is `word[0:k]`. `words[j]` is `reverse(word[0:k])`.
			// If `word[k:]` (the suffix of `words[i]`) is a palindrome, then `words[j] + words[i]` is a palindrome.
			// `words[j] + words[i]` = `reverse(word[0:k])` + `word[0:k]` + `word[k:]`. This is a palindrome.
			if curr.wordIdx != -1 && curr.wordIdx != i && isPalindrome(word[k:]) {
				results = append(results, []int{curr.wordIdx, i})
			}

			char := rune(word[k])
			if _, ok := curr.children[char]; !ok {
				curr = nil // No path, break
				break
			}
			curr = curr.children[char]
		}

		if curr == nil {
			continue // No match for word[0:k] in the Trie
		}

		// After traversing `word` completely. `curr` is the node corresponding to `word`.
		// Case 2: `words[i] + words[j]` is a palindrome, where `len(words[i]) == len(words[j])`.
		// This means `words[j]` is `reverse(words[i])`.
		// If `curr.wordIdx != -1` and `curr.wordIdx != i`:
		//   This means `words[i]` is `reverse(words[curr.wordIdx])`.
		//   Add `[i, curr.wordIdx]` to results.
		if curr.wordIdx != -1 && curr.wordIdx != i {
			results = append(results, []int{i, curr.wordIdx})
		}

		// Case 3: `words[i] + words[j]` is a palindrome, where `words[i]` is shorter than `words[j]`.
		// `words[j] = reverse(words[i]) + palindrome_suffix`.
		// `words[i]` is a prefix of `reverse(words[j])`.
		// `curr.palindromeSuffixesAtNode` contains indices `j` such that `reverse(words[j])` has `word` (which is `words[i]`) as a prefix,
		// and the remaining suffix of `reverse(words[j])` (from `curr` to end) is a palindrome.
		// This means `words[j]` has `reverse(word)` as a suffix, and `words[j][0:len(words[j])-len(word)]` is a palindrome.
		// `words[i] + words[j]` = `word` + `words[j][0:len(words[j])-len(word)]` + `reverse(word)`. This is a palindrome.
		for _, j := range curr.palindromeSuffixesAtNode {
			if j != i {
				results = append(results, []int{i, j})
			}
		}
	}

	return results
}
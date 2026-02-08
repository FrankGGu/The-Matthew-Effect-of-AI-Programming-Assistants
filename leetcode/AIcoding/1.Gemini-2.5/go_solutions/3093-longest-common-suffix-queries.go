package main

import "strings"

type TrieNode struct {
	children [26]*TrieNode
	// bestMatch stores [index, original_length] of the dictionary string
	// with the smallest index that *passes through* this node.
	// This is used to efficiently find the best candidate during queries.
	bestMatch [2]int // [index, original_length]
}

func NewTrieNode() *TrieNode {
	node := &TrieNode{}
	node.bestMatch = [2]int{-1, -1} // Initialize with an invalid index
	return node
}

func (t *TrieNode) Insert(rWord string, idx int, originalLen int) {
	curr := t
	// Update the root's bestMatch if this word is a better candidate
	// (smaller index). This handles cases where a query might not match
	// any character but still needs a default best match.
	if curr.bestMatch[0] == -1 || idx < curr.bestMatch[0] {
		curr.bestMatch = [2]int{idx, originalLen}
	}

	for _, char := range rWord {
		c := char - 'a'
		if curr.children[c] == nil {
			curr.children[c] = NewTrieNode()
		}
		curr = curr.children[c]
		// Update current node's bestMatch.
		// A node's bestMatch stores the smallest index of a dictionary string
		// whose reversed form passes through this node.
		if curr.bestMatch[0] == -1 || idx < curr.bestMatch[0] {
			curr.bestMatch = [2]int{idx, originalLen}
		}
	}
}

func (t *TrieNode) Search(rQuery string) [2]int {
	curr := t
	// Initialize result with the root's best match.
	// This handles cases where the query is empty or doesn't match
	// any path in the Trie beyond the root.
	res := curr.bestMatch

	for _, char := range rQuery {
		c := char - 'a'
		if curr.children[c] == nil {
			// No further match possible. The current `res` is the best we found
			// for the longest possible common suffix.
			break
		}
		curr = curr.children[c]
		// If the current node has a valid bestMatch, it means there's a dictionary
		// string that forms a common suffix up to this depth.
		// Since we are traversing deeper, this potentially represents a longer
		// common suffix. The `bestMatch` at `curr` already stores the smallest
		// index for strings passing through this node. So, we simply update `res`.
		if curr.bestMatch[0] != -1 {
			res = curr.bestMatch
		}
	}
	return res
}

func reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < j; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}

func longestCommonSuffixQueries(wordsContainer []string, wordsQuery []string) []int {
	root := NewTrieNode()

	// Build the Trie by inserting reversed dictionary words.
	for i, word := range wordsContainer {
		rWord := reverse(word)
		root.Insert(rWord, i, len(word))
	}

	// Process each query.
	results := make([]int, len(wordsQuery))
	for i, query := range wordsQuery {
		rQuery := reverse(query)
		bestMatch := root.Search(rQuery)
		results[i] = bestMatch[0] // The index is stored at bestMatch[0]
	}

	return results
}
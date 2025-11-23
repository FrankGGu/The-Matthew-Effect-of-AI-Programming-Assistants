package main

import (
	"sort"
)

const maxBits = 30 // Numbers up to 10^9, which is less than 2^30

type trieNode struct {
	children [2]*trieNode
}

func (t *trieNode) insert(num int) {
	curr := t
	for i := maxBits - 1; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = &trieNode{}
		}
		curr = curr.children[bit]
	}
}

func (t *trieNode) query(num int) int {
	curr := t
	maxXOR := 0
	for i := maxBits - 1; i >= 0; i-- {
		bit := (num >> i) & 1
		// Try to find the opposite bit to maximize XOR
		if curr.children[1-bit] != nil {
			maxXOR |= (1 << i)
			curr = curr.children[1-bit]
		} else {
			// If opposite not found, must take the same bit
			curr = curr.children[bit]
		}
	}
	return maxXOR
}

func maximizeXor(nums []int, queries [][]int) []int {
	sort.Ints(nums)

	type query struct {
		x, m, originalIndex int
	}
	sortedQueries := make([]query, len(queries))
	for i := 0; i < len(queries); i++ {
		sortedQueries[i] = query{queries[i][0], queries[i][1], i}
	}

	sort.Slice(sortedQueries, func(i, j int) bool {
		return sortedQueries[i].m < sortedQueries[j].m
	})

	ans := make([]int, len(queries))
	for i := range ans {
		ans[i] = -1
	}

	trie := &trieNode{}
	numIdx := 0

	for _, q := range sortedQueries {
		x, m, originalIndex := q.x, q.m, q.originalIndex

		for numIdx < len(nums) && nums[numIdx] <= m {
			trie.insert(nums[numIdx])
			numIdx++
		}

		if numIdx > 0 {
			ans[originalIndex] = trie.query(x)
		}
	}

	return ans
}
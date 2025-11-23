package main

import (
	"container/heap"
	"math"
)

type TrieNode struct {
	children [26]*TrieNode
	minCost  int // Stores the minimum cost to form a word ending at this node
}

func newTrieNode() *TrieNode {
	return &TrieNode{
		minCost: math.MaxInt, // Initialize with max value, indicating no word ends here yet or a very high cost
	}
}

func (t *TrieNode) insert(word string, cost int) {
	curr := t
	for _, char := range word {
		idx := char - 'a'
		if curr.children[idx] == nil {
			curr.children[idx] = newTrieNode()
		}
		curr = curr.children[idx]
	}
	curr.minCost = min(curr.minCost, cost)
}

type Item struct {
	cost  int
	index int
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].cost < h[j].cost }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x any) {
	*h = append(*h, x.(Item))
}

func (h *MinHeap) Pop() any {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func minimumCost(target string, words []string, costs []int) int {
	trieRoot := newTrieNode()
	for i := 0; i < len(words); i++ {
		trieRoot.insert(words[i], costs[i])
	}

	n := len(target)
	dp := make([]int, n+1)
	for i := range dp {
		dp[i] = math.MaxInt // dp[i] stores the minimum cost to form target[0:i]
	}
	dp[0] = 0 // Cost to form an empty prefix is 0

	pq := &MinHeap{}
	heap.Init(pq)
	heap.Push(pq, Item{cost: 0, index: 0}) // Start with cost 0 at index 0

	for pq.Len() > 0 {
		currItem := heap.Pop(pq).(Item)
		currCost := currItem.cost
		currIdx := currItem.index

		// If we found a cheaper path to currIdx already, skip
		if currCost > dp[currIdx] {
			continue
		}

		// If we reached the end of the target string, this is the minimum cost
		if currIdx == n {
			return currCost
		}

		// Traverse the target string starting from currIdx using the Trie
		// to find possible next segments (words)
		currTrieNode := trieRoot
		for j := currIdx; j < n; j++ {
			charIdx := target[j] - 'a'
			if currTrieNode.children[charIdx] == nil {
				// No word in the Trie starts with this prefix from currIdx
				break
			}
			currTrieNode = currTrieNode.children[charIdx]

			// If this Trie node marks the end of a valid word
			if currTrieNode.minCost != math.MaxInt {
				// We found a word `target[currIdx : j+1]` with cost `currTrieNode.minCost`
				newCost := currCost + currTrieNode.minCost
				// If this new path is cheaper to reach index `j+1`
				if newCost < dp[j+1] {
					dp[j+1] = newCost
					heap.Push(pq, Item{cost: newCost, index: j + 1})
				}
			}
		}
	}

	// If dp[n] is still math.MaxInt, it means the target string cannot be formed
	if dp[n] == math.MaxInt {
		return -1
	}
	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
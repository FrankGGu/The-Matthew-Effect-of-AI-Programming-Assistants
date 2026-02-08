package main

import (
	"sort"
)

func smallestStringWithSwaps(s string, pairs [][]int) string {
	parent := make([]int, len(s))
	for i := range parent {
		parent[i] = i
	}

	var find func(int) int
	find = func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	for _, pair := range pairs {
		rootA := find(pair[0])
		rootB := find(pair[1])
		if rootA != rootB {
			parent[rootB] = rootA
		}
	}

	components := make(map[int][]int)
	for i := range s {
		root := find(i)
		components[root] = append(components[root], i)
	}

	result := make([]byte, len(s))
	for _, indices := range components {
		letters := make([]byte, len(indices))
		for i, idx := range indices {
			letters[i] = s[idx]
		}
		sort.Slice(letters, func(i, j int) bool {
			return letters[i] < letters[j]
		})
		for i, idx := range indices {
			result[idx] = letters[i]
		}
	}

	return string(result)
}
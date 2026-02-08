package main

import (
	"sort"
)

type DSU struct {
	parent []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &DSU{parent: parent}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) {
	rootI := d.find(i)
	rootJ := d.find(j)
	if rootI != rootJ {
		d.parent[rootJ] = rootI
	}
}

func smallestStringWithSwaps(s string, pairs [][]int) string {
	n := len(s)
	dsu := newDSU(n)

	for _, pair := range pairs {
		dsu.union(pair[0], pair[1])
	}

	componentChars := make(map[int][]rune)
	componentIndices := make(map[int][]int)

	for i, char := range s {
		root := dsu.find(i)
		componentChars[root] = append(componentChars[root], char)
		componentIndices[root] = append(componentIndices[root], i)
	}

	result := make([]rune, n)
	for root := range componentChars {
		chars := componentChars[root]
		indices := componentIndices[root]

		sort.Slice(chars, func(i, j int) bool {
			return chars[i] < chars[j]
		})

		sort.Ints(indices)

		for i := 0; i < len(chars); i++ {
			result[indices[i]] = chars[i]
		}
	}

	return string(result)
}
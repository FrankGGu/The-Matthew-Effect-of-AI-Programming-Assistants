package main

import (
	"strings"
)

type DSU struct {
	parent       []int
	smallestChar []byte
}

func newDSU(size int) *DSU {
	parent := make([]int, size)
	smallestChar := make([]byte, size)
	for i := 0; i < size; i++ {
		parent[i] = i
		smallestChar[i] = byte('a' + i)
	}
	return &DSU{parent: parent, smallestChar: smallestChar}
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
		// The root whose smallestChar is lexicographically smaller becomes the new root.
		// Its smallestChar value is already correct.
		if d.smallestChar[rootI] < d.smallestChar[rootJ] {
			d.parent[rootJ] = rootI
		} else { // d.smallestChar[rootJ] <= d.smallestChar[rootI]
			d.parent[rootI] = rootJ
		}
	}
}

func smallestEquivalentString(s1 string, s2 string, baseStr string) string {
	dsu := newDSU(26) // For 'a' through 'z'

	for k := 0; k < len(s1); k++ {
		char1Idx := int(s1[k] - 'a')
		char2Idx := int(s2[k] - 'a')
		dsu.union(char1Idx, char2Idx)
	}

	var result strings.Builder
	for k := 0; k < len(baseStr); k++ {
		charIdx := int(baseStr[k] - 'a')
		root := dsu.find(charIdx)
		result.WriteByte(dsu.smallestChar[root])
	}

	return result.String()
}
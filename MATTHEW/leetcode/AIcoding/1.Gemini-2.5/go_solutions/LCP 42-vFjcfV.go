package main

import (
	"sort"
)

func toyRingToss(size []int, radius []int) int {
	sort.Ints(size)
	sort.Ints(radius)

	n := len(size)
	m := len(radius)

	count := 0
	i := 0 // Pointer for toys
	j := 0 // Pointer for rings

	for i < n && j < m {
		if radius[j] >= size[i] {
			// This ring can fit the current toy
			count++
			i++ // Move to the next toy
			j++ // Move to the next ring
		} else {
			// This ring is too small for the current toy.
			// Since both arrays are sorted, this ring will also be too small for any subsequent toys.
			// Discard this ring and try the next larger ring.
			j++
		}
	}

	return count
}
package main

import (
	"math"
)

func pathInZigZagTree(label int) []int {
	path := []int{}
	current := label

	for current > 0 {
		path = append(path, current)
		if current == 1 {
			break
		}

		// Determine the current level (0-indexed)
		// For label=1, level=0
		// For label=2,3, level=1
		// For label=4-7, level=2
		level := int(math.Log2(float64(current)))

		// Calculate the min and max values for the current level
		levelMin := 1 << level
		levelMax := (1 << (level + 1)) - 1

		// Calculate the min and max values for the parent's level
		parentLevel := level - 1
		parentLevelMin := 1 << parentLevel
		parentLevelMax := (1 << (parentLevel + 1)) - 1

		// The parent of 'current' is found by:
		// 1. Find the 'mirror' of 'current' in its own level.
		//    The mirror value for 'x' in a level [min, max] is 'min + max - x'.
		//    This 'mirror_current' represents the value 'current' would have
		//    if its level was labelled in standard L-R order.
		mirrorCurrent := levelMin + levelMax - current

		// 2. Find the 'standard parent' of this mirror value.
		//    In a standard binary tree, the parent of 'x' is 'x / 2'.
		standardParent := mirrorCurrent / 2

		// 3. Convert this 'standard_parent' back to its actual zigzag label
		//    within the parent's level.
		//    The parent's level might also be zigzag (R-L).
		//    So, the actual parent value is the 'mirror' of 'standard_parent'
		//    within the parent's level bounds.
		current = parentLevelMin + parentLevelMax - standardParent
	}

	// Reverse the path to get it from root to label
	for i, j := 0, len(path)-1; i < j; i, j = i+1, j-1 {
		path[i], path[j] = path[j], path[i]
	}

	return path
}
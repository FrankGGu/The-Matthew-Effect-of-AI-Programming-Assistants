package main

import (
	"container/list"
)

func maxCandies(status []int, candies []int, keys [][]int, containedBoxes [][]int, initialBoxes []int) int {
	n := len(status)
	totalCandies := 0

	opened := make([]bool, n)           // True if box i has been opened and its contents processed
	hasKey := make([]bool, n)           // True if we possess a key for box i
	boxesInPossession := make([]bool, n) // True if box i is in our possession (initial or found inside another box)

	// Initialize boxesInPossession with initialBoxes
	for _, boxIdx := range initialBoxes {
		boxesInPossession[boxIdx] = true
	}

	q := list.New() // BFS queue for boxes that are currently openable and not yet opened

	for {
		// Phase 1: Identify all currently openable and not yet opened boxes, and add them to the queue.
		// This loop continues until no new boxes can be opened in an entire iteration.
		somethingNewOpenedInThisIteration := false

		// Iterate through all boxes to find ones that are now openable
		for i := 0; i < n; i++ {
			if !opened[i] && boxesInPossession[i] && (status[i] == 1 || hasKey[i]) {
				q.PushBack(i)
				opened[i] = true // Mark as opened to prevent re-adding to queue in this or future outer loop iterations
				somethingNewOpenedInThisIteration = true
			}
		}

		// If no new boxes were added to the queue in this scan, and the queue is also empty,
		// it means no further progress can be made.
		if !somethingNewOpenedInThisIteration && q.Len() == 0 {
			break
		}

		// Phase 2: Process the current queue (standard BFS)
		for q.Len() > 0 {
			currBox := q.Remove(q.Front()).(int)

			totalCandies += candies[currBox]

			// Acquire keys from the current box
			for _, keyIdx := range keys[currBox] {
				hasKey[keyIdx] = true
			}

			// Acquire contained boxes from the current box
			for _, containedBoxIdx := range containedBoxes[currBox] {
				boxesInPossession[containedBoxIdx] = true
			}
		}
		// After processing the current queue, hasKey or boxesInPossession might have changed.
		// The outer loop will repeat to check if these changes made any previously unopenable boxes openable.
	}

	return totalCandies
}
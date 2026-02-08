package main

import (
	"math/rand"
	"time"
)

type SkipListNode struct {
	val     int
	forward []*SkipListNode // forward[i] points to the next node at level i
}

type SkipList struct {
	head  *SkipListNode // Dummy head node
	level int           // Current max level of the skip list
	size  int           // Number of elements in the skip list
	rand  *rand.Rand    // Random number generator for level generation
}

const MAX_LEVEL = 16 // Max level for the skip list (log2(1000) is about 10, 16 is safe)
const P = 0.5        // Probability for increasing level

func newSkipList() *SkipList {
	// Initialize head node with a dummy value (e.g., 0 or -1) and max level forward pointers.
	head := &SkipListNode{val: 0, forward: make([]*SkipListNode, MAX_LEVEL)}
	// Use a new source for each SkipList to ensure different random sequences if multiple lists are created.
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	return &SkipList{head: head, level: 0, size: 0, rand: r}
}

func (sl *SkipList) randomLevel() int {
	level := 0
	for sl.rand.Float64() < P && level < MAX_LEVEL-1 {
		level++
	}
	return level
}

func (sl *SkipList) Insert(val int) bool {
	update := make([]*SkipListNode, MAX_LEVEL) // Stores pointers to nodes that need to be updated at each level
	current := sl.head

	// Traverse the skip list to find the insertion point and fill the update array
	for i := sl.level; i >= 0; i-- {
		for current.forward[i] != nil && current.forward[i].val < val {
			current = current.forward[i]
		}
		update[i] = current
	}

	// Move to the level 0 forward pointer to check if the value already exists
	current = current.forward[0]

	if current != nil && current.val == val {
		return false // Value already exists
	}

	sl.size++
	newLevel := sl.randomLevel() // Generate a random level for the new node

	// If the new node's level is greater than the current max level of the skip list,
	// update the head's forward pointers for the new levels.
	if newLevel > sl.level {
		for i := sl.level + 1; i <= newLevel; i++ {
			update[i] = sl.head
		}
		sl.level = newLevel
	}

	// Create the new node and insert it into the skip list
	newNode := &SkipListNode{val: val, forward: make([]*SkipListNode, newLevel+1)}
	for i := 0; i <= newLevel; i++ {
		newNode.forward[i] = update[i].forward[i]
		update[i].forward[i] = newNode
	}
	return true
}

func (sl *SkipList) FindPrev(val int) (int, bool) {
	current := sl.head
	for i := sl.level; i >= 0; i-- {
		for current.forward[i] != nil && current.forward[i].val < val {
			current = current.forward[i]
		}
	}
	// After the loop, 'current' is the node whose value is the largest element strictly less than 'val'.
	if current != sl.head { // If current is not the dummy head, a predecessor was found.
		return current.val, true
	}
	return 0, false // No element strictly less than val
}

func (sl *SkipList) FindNext(val int) (int, bool) {
	current := sl.head
	for i := sl.level; i >= 0; i-- {
		for current.forward[i] != nil && current.forward[i].val <= val {
			current = current.forward[i]
		}
	}
	// After the loop, 'current' is the node whose value is less than or equal to 'val'.
	// Its forward[0] pointer will point to the smallest node strictly greater than 'val'.
	if current.forward[0] != nil {
		return current.forward[0].val, true
	}
	return 0, false // No element strictly greater than val
}

func sumImbalanceNumbers(nums []int) int {
	n := len(nums)
	totalImbalance := 0

	// Iterate through all possible starting points of subarrays
	for i := 0; i < n; i++ {
		sl := newSkipList()         // A new skip list for each starting point 'i'
		currentImbalance := 0       // Imbalance for the current subarray nums[i...j]

		// Iterate through all possible ending points of subarrays starting at 'i'
		for j := i; j < n; j++ {
			num := nums[j]

			// Try to insert the current number into the skip list.
			// If it was already present, the set of unique elements doesn't change,
			// so the imbalance number for nums[i...j] is the same as for nums[i...j-1].
			wasNew := sl.Insert(num)
			if !wasNew {
				totalImbalance += currentImbalance
				continue
			}

			// If num is a new element, update currentImbalance
			prevVal, hasPrev := sl.FindPrev(num)
			nextVal, hasNext := sl.FindNext(num)

			// If prevVal and nextVal existed, the pair (prevVal, nextVal) was an adjacent pair.
			// Now 'num' is inserted between them, breaking this adjacency.
			// If (prevVal, nextVal) contributed to imbalance (i.e., nextVal - prevVal > 1),
			// its contribution is removed.
			if hasPrev && hasNext {
				if nextVal-prevVal > 1 {
					currentImbalance--
				}
			}

			// Check new adjacent pair (prevVal, num)
			// If prevVal exists and num - prevVal > 1, it's a new imbalance pair.
			if hasPrev {
				if num-prevVal > 1 {
					currentImbalance++
				}
			}

			// Check new adjacent pair (num, nextVal)
			// If nextVal exists and nextVal - num > 1, it's a new imbalance pair.
			if hasNext {
				if nextVal-num > 1 {
					currentImbalance++
				}
			}

			// Add the imbalance of the current subarray nums[i...j] to the total sum
			totalImbalance += currentImbalance
		}
	}
	return totalImbalance
}
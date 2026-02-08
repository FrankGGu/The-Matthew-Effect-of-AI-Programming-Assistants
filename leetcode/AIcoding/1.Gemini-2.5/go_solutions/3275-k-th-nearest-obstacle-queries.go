package main

import (
	"sort"
)

type FenwickTree struct {
	data []int
	size int // Max index + 1 (size of the compressed coordinate space)
}

func newFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		data: make([]int, size+1), // 1-indexed internally
		size: size,
	}
}

func (ft *FenwickTree) update(idx int, val int) {
	idx++ // Convert to 1-indexed for BIT
	for idx <= ft.size {
		ft.data[idx] += val
		idx += idx & (-idx)
	}
}

func (ft *FenwickTree) query(idx int) int {
	idx++ // Convert to 1-indexed for BIT
	sum := 0
	for idx > 0 {
		sum += ft.data[idx]
		idx -= idx & (-idx)
	}
	return sum
}

func (ft *FenwickTree) findKth(k int) int {
	if k <= 0 {
		return -1
	}

	low, high := 0, ft.size-1 // Search space for 0-indexed compressed x
	ansIdx := -1

	for low <= high {
		mid := low + (high-low)/2
		if ft.query(mid) >= k { // If sum up to mid is >= k, then k-th element is at or before mid
			ansIdx = mid
			high = mid - 1
		} else { // Sum up to mid is < k, k-th element is after mid
			low = mid + 1
		}
	}
	return ansIdx
}

type Event struct {
	distSq int // Squared distance from origin
	x      int // x-coordinate for obstacles, or k for queries
	idx    int // Original index for queries, or -1 for obstacles
	isQuery bool
}

func kthNearestObstacleQueries(obstacles [][]int, queries [][]int) []int {
	// 1. Collect all unique x-coordinates for coordinate compression
	allXMap := make(map[int]struct{})
	for _, obs := range obstacles {
		allXMap[obs[0]] = struct{}{}
	}

	uniqueX := make([]int, 0, len(allXMap))
	for x := range allXMap {
		uniqueX = append(uniqueX, x)
	}
	sort.Ints(uniqueX)

	xMap := make(map[int]int) // Maps original x to compressed index (0-indexed)
	for i, x := range uniqueX {
		xMap[x] = i
	}

	// 2. Create events
	events := make([]Event, 0, len(obstacles)+len(queries))

	for _, obs := range obstacles {
		x, y := obs[0], obs[1]
		distSq := x*x + y*y
		events = append(events, Event{
			distSq:  distSq,
			x:       x, // Store original x
			idx:     -1,
			isQuery: false,
		})
	}

	for i, q := range queries {
		maxDist, k := q[0], q[1]
		distSq := maxDist * maxDist
		events = append(events, Event{
			distSq:  distSq,
			x:       k, // Store k for queries
			idx:     i,
			isQuery: true,
		})
	}

	// 3. Sort events
	sort.Slice(events, func(i, j int) bool {
		if events[i].distSq != events[j].distSq {
			return events[i].distSq < events[j].distSq
		}
		// If distSq is equal, process obstacles before queries
		// This ensures that obstacles at the current max_distance are included
		// before a query at that max_distance is processed.
		return !events[i].isQuery // Obstacle (false) comes before Query (true)
	})

	// 4. Process events using Fenwick Tree
	ans := make([]int, len(queries))
	// Fenwick tree size is the number of unique x-coordinates
	ft := newFenwickTree(len(uniqueX))

	for _, event := range events {
		if !event.isQuery { // Obstacle event
			compressedX := xMap[event.x]
			ft.update(compressedX, 1)
		} else { // Query event
			k := event.x // event.x holds k for queries
			queryIdx := event.idx

			// Check if there are enough obstacles for the k-th element
			if k > ft.query(len(uniqueX)-1) { // query(len(uniqueX)-1) gives total count of obstacles
				ans[queryIdx] = -1 // No k-th element
			} else {
				// Find the k-th smallest x-coordinate
				compressedXIdx := ft.findKth(k)
				ans[queryIdx] = uniqueX[compressedXIdx]
			}
		}
	}

	return ans
}
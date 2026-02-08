package main

import (
	"sort"
)

type Event struct {
	x    int
	y1   int // bottom-left y-coordinate of the square for centers
	y2   int // top-right y-coordinate of the square for centers
	typ  int // +1 for add, -1 for remove
}

type SegTreeNode struct {
	maxVal int
	lazy   int // lazy tag for range updates
}

var segTree []SegTreeNode
var yCoords []int // Compressed unique y-coordinates

func build(node, start, end int) {
	segTree[node] = SegTreeNode{maxVal: 0, lazy: 0}
	if start == end {
		return
	}
	mid := (start + end) / 2
	build(2*node, start, mid)
	build(2*node+1, mid+1, end)
}

func push(node int) {
	if segTree[node].lazy != 0 {
		segTree[2*node].maxVal += segTree[node].lazy
		segTree[2*node].lazy += segTree[node].lazy
		segTree[2*node+1].maxVal += segTree[node].lazy
		segTree[2*node+1].lazy += segTree[node].lazy
		segTree[node].lazy = 0
	}
}

func update(node, start, end, queryStart, queryEnd, val int) {
	if queryStart > end || queryEnd < start { // No overlap
		return
	}
	if queryStart <= start && end <= queryEnd { // Complete overlap
		segTree[node].maxVal += val
		segTree[node].lazy += val
		return
	}

	push(node) // Push lazy tag before going down
	mid := (start + end) / 2
	update(2*node, start, mid, queryStart, queryEnd, val)
	update(2*node+1, mid+1, end, queryStart, queryEnd, val)
	segTree[node].maxVal = max(segTree[2*node].maxVal, segTree[2*node+1].maxVal)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func getStrongestBlessingField(points [][]int, r int) int {
	events := make([]Event, 0, len(points)*2)
	ySet := make(map[int]struct{})

	for _, p := range points {
		x, y := p[0], p[1]
		// Each point (x,y) implies that a square of radius r centered at (cx, cy)
		// can cover (x,y) if cx is in [x-r, x+r] and cy is in [y-r, y+r].
		// We are looking for a center (cx, cy) that is covered by the maximum number of such squares.
		// This is a maximum depth problem for axis-aligned squares.
		events = append(events, Event{x - r, y - r, y + r, 1})    // Add event for left edge of a center-square
		events = append(events, Event{x + r + 1, y - r, y + r, -1}) // Remove event for right edge + 1

		ySet[y-r] = struct{}{}
		ySet[y+r] = struct{}{}
	}

	// Collect and sort unique y-coordinates for compression
	for y := range ySet {
		yCoords = append(yCoords, y)
	}
	sort.Ints(yCoords)

	// Create a map from actual y-coordinate to compressed index
	yMap := make(map[int]int)
	for i, y := range yCoords {
		yMap[y] = i
	}

	// Sort events: primary by x-coordinate, secondary by type (add before remove)
	sort.Slice(events, func(i, j int) bool {
		if events[i].x != events[j].x {
			return events[i].x < events[j].x
		}
		return events[i].typ < events[j].typ // Process add events (typ=1) before remove events (typ=-1)
	})

	maxBlessing := 0
	numYCoords := len(yCoords)
	if numYCoords == 0 { // No points, no y-coordinates, max blessing is 0
		return 0
	}

	// Initialize segment tree
	segTree = make([]SegTreeNode, 4*numYCoords)
	build(1, 0, numYCoords-1)

	for _, event := range events {
		// Convert y-coordinates to compressed indices
		y1Idx := yMap[event.y1]
		y2Idx := yMap[event.y2]

		// Update the segment tree for the range [y1Idx, y2Idx]
		update(1, 0, numYCoords-1, y1Idx, y2Idx, event.typ)

		// The maximum value in the segment tree root (segTree[1].maxVal)
		// represents the maximum overlap at the current x-sweep line.
		maxBlessing = max(maxBlessing, segTree[1].maxVal)
	}

	return maxBlessing
}
package main

import "math"

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
		d.parent[rootI] = rootJ
	}
}

func checkRectangleCornerIsReachable(width int, height int, circles [][]int) bool {
	n := len(circles)

	// DSU nodes:
	// 0 to n-1: represent each circle
	// n: represents the left boundary (x=0)
	// n+1: represents the right boundary (x=width)
	// n+2: represents the bottom boundary (y=0)
	// n+3: represents the top boundary (y=height)
	dsu := newDSU(n + 4)

	leftBoundaryIdx := n
	rightBoundaryIdx := n + 1
	bottomBoundaryIdx := n + 2
	topBoundaryIdx := n + 3

	// Connect circles to the rectangle boundaries if they touch or cross
	for i := 0; i < n; i++ {
		x, y, r := circles[i][0], circles[i][1], circles[i][2]

		if x-r <= 0 { // Circle touches or crosses the left boundary (x=0)
			dsu.union(i, leftBoundaryIdx)
		}
		if x+r >= width { // Circle touches or crosses the right boundary (x=width)
			dsu.union(i, rightBoundaryIdx)
		}
		if y-r <= 0 { // Circle touches or crosses the bottom boundary (y=0)
			dsu.union(i, bottomBoundaryIdx)
		}
		if y+r >= height { // Circle touches or crosses the top boundary (y=height)
			dsu.union(i, topBoundaryIdx)
		}
	}

	// Connect overlapping or touching circles
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			x1, y1, r1 := circles[i][0], circles[i][1], circles[i][2]
			x2, y2, r2 := circles[j][0], circles[j][1], circles[j][2]

			// Calculate squared distance between circle centers
			dx := int64(x1 - x2)
			dy := int64(y1 - y2)
			distSq := dx*dx + dy*dy

			// Calculate squared sum of radii
			radiusSum := int64(r1 + r2)
			radiusSumSq := radiusSum * radiusSum

			// If circles overlap or touch, union their sets
			if distSq <= radiusSumSq {
				dsu.union(i, j)
			}
		}
	}

	// Get the representative (root) for each boundary component
	rootLeft := dsu.find(leftBoundaryIdx)
	rootRight := dsu.find(rightBoundaryIdx)
	rootBottom := dsu.find(bottomBoundaryIdx)
	rootTop := dsu.find(topBoundaryIdx)

	// The path from (0,0) to (width,height) is blocked if a continuous chain of circles
	// connects any of the following pairs of boundary components:
	// 1. Left boundary to Right boundary (horizontal block)
	// 2. Bottom boundary to Top boundary (vertical block)
	// 3. Left boundary to Top boundary AND Bottom boundary to Right boundary (diagonal block)
	// 4. Left boundary to Bottom boundary AND Top boundary to Right boundary (other diagonal block)

	// Condition 1: Horizontal block
	if rootLeft == rootRight {
		return false
	}
	// Condition 2: Vertical block
	if rootBottom == rootTop {
		return false
	}

	// Condition 3: Diagonal block (e.g., from top-left region to bottom-right region)
	// This means obstacles connect the left side to the top side, AND
	// obstacles connect the bottom side to the right side.
	// If these two connections are part of the same or different components that form a continuous barrier.
	if rootLeft == rootTop && rootBottom == rootRight {
		return false
	}

	// Condition 4: Other diagonal block (e.g., from bottom-left region to top-right region)
	// This means obstacles connect the left side to the bottom side, AND
	// obstacles connect the top side to the right side.
	if rootLeft == rootBottom && rootTop == rootRight {
		return false
	}

	// If none of the blocking conditions are met, a path exists from (0,0) to (width,height).
	return true
}
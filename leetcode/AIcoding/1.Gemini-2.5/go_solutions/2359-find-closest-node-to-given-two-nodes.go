package main

import (
	"math"
)

func closestMeetingNode(edges []int, node1 int, node2 int) int {
	n := len(edges)

	dist1 := make([]int, n)
	dist2 := make([]int, n)
	for i := 0; i < n; i++ {
		dist1[i] = -1
		dist2[i] = -1
	}

	q := []int{}
	head := 0

	// BFS from node1
	q = append(q, node1)
	dist1[node1] = 0
	head = 0
	for head < len(q) {
		u := q[head]
		head++

		v := edges[u]
		if v != -1 && dist1[v] == -1 {
			dist1[v] = dist1[u] + 1
			q = append(q, v)
		}
	}

	// BFS from node2
	q = []int{} // Reset queue
	q = append(q, node2)
	dist2[node2] = 0
	head = 0
	for head < len(q) {
		u := q[head]
		head++

		v := edges[u]
		if v != -1 && dist2[v] == -1 {
			dist2[v] = dist2[u] + 1
			q = append(q, v)
		}
	}

	minMaxDist := math.MaxInt32
	resultNode := -1

	for i := 0; i < n; i++ {
		if dist1[i] != -1 && dist2[i] != -1 {
			currentMaxDist := max(dist1[i], dist2[i])
			if currentMaxDist < minMaxDist {
				minMaxDist = currentMaxDist
				resultNode = i
			} else if currentMaxDist == minMaxDist {
				if i < resultNode {
					resultNode = i
				}
			}
		}
	}

	return resultNode
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
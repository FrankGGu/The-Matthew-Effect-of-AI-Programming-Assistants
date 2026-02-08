package main

import (
	"container/heap"
	"math"
)

type State struct {
	cost int
	time int
	city int
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
	// Prioritize states with lower cost.
	// If costs are equal, prioritize states with lower time (optional, but can help with tie-breaking).
	if pq[i].cost != pq[j].cost {
		return pq[i].cost < pq[j].cost
	}
	return pq[i].time < pq[j].time
}
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(State)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minCost(n int, edges [][]int, maxTime int) int {
	adj := make([][][3]int, n) // [from_city] -> list of [to_city, travel_time, travel_cost]
	for _, edge := range edges {
		u, v, t, c := edge[0], edge[1], edge[2], edge[3]
		adj[u] = append(adj[u], [3]int{v, t, c})
		adj[v] = append(adj[v], [3]int{u, t, c}) // Graph is undirected
	}

	// dp[city][time_elapsed] = min_cost to reach 'city' having spent 'time_elapsed'
	dp := make([][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, maxTime+1)
		for j := 0; j <= maxTime; j++ {
			dp[i][j] = math.MaxInt32 // Initialize with infinity
		}
	}

	// Starting point: city 0, time 0, cost 0
	dp[0][0] = 0

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, State{cost: 0, time: 0, city: 0})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(State)
		currCost := curr.cost
		currTime := curr.time
		currCity := curr.city

		// If we've already found a cheaper path to currCity at currTime, skip this one
		if currCost > dp[currCity][currTime] {
			continue
		}

		// Explore neighbors
		for _, neighborEdge := range adj[currCity] {
			nextCity := neighborEdge[0]
			travelTime := neighborEdge[1]
			travelCost := neighborEdge[2]

			newTime := currTime + travelTime
			newCost := currCost + travelCost

			// Check if new path is within maxTime and is cheaper
			if newTime <= maxTime {
				if newCost < dp[nextCity][newTime] {
					dp[nextCity][newTime] = newCost
					heap.Push(&pq, State{cost: newCost, time: newTime, city: nextCity})
				}
			}
		}
	}

	// After Dijkstra, find the minimum cost to reach city n-1 within maxTime
	minTotalCost := math.MaxInt32
	for t := 0; t <= maxTime; t++ {
		if dp[n-1][t] < minTotalCost {
			minTotalCost = dp[n-1][t]
		}
	}

	if minTotalCost == math.MaxInt32 {
		return -1 // Cannot reach destination city n-1 within maxTime
	}
	return minTotalCost
}
import (
	"container/heap"
	"sort"
)

type Edge struct {
	To    int
	Time  int
	Cost  int
}

type Node struct {
	City  int
	Time  int
	Cost  int
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].Time != pq[j].Time {
		return pq[i].Time < pq[j].Time
	}
	return pq[i].Cost < pq[j].Cost
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(Node))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minCost(maxTime int, edges [][]int, passingFees []int) int {
	n := len(passingFees)
	adj := make([][]Edge, n)
	for _, edge := range edges {
		u, v, time := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], Edge{To: v, Time: time, Cost: 0})
		adj[v] = append(adj[v], Edge{To: u, Time: time, Cost: 0})
	}

	times := make([]int, n)
	costs := make([]int, n)
	for i := range times {
		times[i] = maxTime + 1
		costs[i] = -1
	}

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, Node{City: 0, Time: 0, Cost: passingFees[0]})
	times[0] = 0
	costs[0] = passingFees[0]

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Node)
		city, time, cost := curr.City, curr.Time, curr.Cost

		if city == n-1 {
			return cost
		}

		if time > times[city] {
			continue
		}

		for _, edge := range adj[city] {
			nextCity, nextTime := edge.To, edge.Time
			newTime := time + nextTime
			newCost := cost + passingFees[nextCity]

			if newTime <= maxTime {
				if times[nextCity] > newTime {
					times[nextCity] = newTime
					costs[nextCity] = newCost
					heap.Push(pq, Node{City: nextCity, Time: newTime, Cost: newCost})
				} else if times[nextCity] == newTime && costs[nextCity] > newCost {
					costs[nextCity] = newCost
					heap.Push(pq, Node{City: nextCity, Time: newTime, Cost: newCost})
				}
			}
		}
	}

	return -1
}
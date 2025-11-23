package main

import (
	"container/heap"
)

type Server struct {
	weight int
	index  int
	finishTime int // The time this server becomes free.
}

type AvailableServers []*Server

func (h AvailableServers) Len() int { return len(h) }
func (h AvailableServers) Less(i, j int) bool {
	if h[i].weight != h[j].weight {
		return h[i].weight < h[j].weight
	}
	return h[i].index < h[j].index
}
func (h AvailableServers) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *AvailableServers) Push(x interface{}) {
	*h = append(*h, x.(*Server))
}

func (h *AvailableServers) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type BusyServers []*Server

func (h BusyServers) Len() int { return len(h) }
func (h BusyServers) Less(i, j int) bool {
	if h[i].finishTime != h[j].finishTime {
		return h[i].finishTime < h[j].finishTime
	}
	if h[i].weight != h[j].weight {
		return h[i].weight < h[j].weight
	}
	return h[i].index < h[j].index
}
func (h BusyServers) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *BusyServers) Push(x interface{}) {
	*h = append(*h, x.(*Server))
}

func (h *BusyServers) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func assignTasks(servers []int, tasks []int) []int {
	ans := make([]int, len(tasks))

	available := &AvailableServers{}
	heap.Init(available)

	busy := &BusyServers{}
	heap.Init(busy)

	for i, w := range servers {
		heap.Push(available, &Server{weight: w, index: i, finishTime: 0})
	}

	currentTime := 0 // Tracks the earliest time a new task can start processing.

	for j := 0; j < len(tasks); j++ {
		// Task `j` arrives at time `j`.
		// The effective time for processing this task is `max(currentTime, j)`.
		// This ensures we don't process a task before it arrives, and also respects
		// any delays caused by previous tasks if all servers were busy.
		effectiveTime := max(currentTime, j)

		// Phase 1: Move servers from busy to available whose finishTime <= effectiveTime.
		// This loop ensures that `available` heap has all servers that are free by `effectiveTime`.
		for busy.Len() > 0 && busy.Peek().(*Server).finishTime <= effectiveTime {
			s := heap.Pop(busy).(*Server)
			heap.Push(available, s)
		}

		// Phase 2: If no servers are available yet, advance time until one becomes free.
		// Then move all servers that become free at that new time to `available`.
		if available.Len() == 0 {
			// No servers are available at `effectiveTime`.
			// Pop the earliest finishing server from `busy`.
			s := heap.Pop(busy).(*Server)
			effectiveTime = s.finishTime // Advance `effectiveTime` to when this server becomes free.
			heap.Push(available, s)    // This server is now available.

			// Now that `effectiveTime` has advanced, check if any *other* busy servers also become free
			// at this new `effectiveTime`.
			for busy.Len() > 0 && busy.Peek().(*Server).finishTime <= effectiveTime {
				s2 := heap.Pop(busy).(*Server)
				heap.Push(available, s2)
			}
		}

		// Phase 3: Assign task `j` using the best available server.
		chosenServer := heap.Pop(available).(*Server)
		ans[j] = chosenServer.index
		chosenServer.finishTime = effectiveTime + tasks[j] // Server is busy until this time, free FROM this time.
		heap.Push(busy, chosenServer)

		// The global simulation time advances to at least the effectiveTime of this task.
		// This ensures that the next task (j+1) doesn't start before this one's effectiveTime.
		currentTime = effectiveTime 
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
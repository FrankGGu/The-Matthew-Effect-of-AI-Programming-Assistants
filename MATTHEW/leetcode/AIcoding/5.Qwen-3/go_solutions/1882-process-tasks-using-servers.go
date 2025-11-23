package main

import (
	"container/heap"
	"sort"
)

type Server struct {
	id      int
	available int
}

type Servers []*Server

func (s Servers) Len() int { return len(s) }

func (s Servers) Less(i, j int) bool {
	if s[i].available == s[j].available {
		return s[i].id < s[j].id
	}
	return s[i].available < s[j].available
}

func (s Servers) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

func (s *Servers) Push(x interface{}) {
	*s = append(*s, x.(*Server))
}

func (s *Servers) Pop() interface{} {
	old := *s
	n := len(old)
	x := old[n-1]
	*s = old[0 : n-1]
	return x
}

func (s Servers) Top() *Server {
	return s[0]
}

func assignTasks(servers []int, tasks []int) []int {
	n := len(servers)
	result := make([]int, n)
	availableServers := make(Servers, n)
	for i := 0; i < n; i++ {
		availableServers[i] = &Server{id: i, available: 0}
	}
	heap.Init(&availableServers)

	// For busy servers, we use a min-heap based on their available time
	busyServers := make(PriorityQueue, 0)
	heap.Init(&busyServers)

	for i := 0; i < n; i++ {
		// Free up servers that have completed their tasks
		for len(busyServers) > 0 && busyServers[0].available <= i {
			server := heap.Pop(&busyServers).(*Server)
			heap.Push(&availableServers, server)
		}

		// If no available servers, wait until the next server becomes available
		if availableServers.Len() == 0 {
			nextAvailableTime := busyServers[0].available
			// Free up all servers that become available at nextAvailableTime
			for len(busyServers) > 0 && busyServers[0].available == nextAvailableTime {
				server := heap.Pop(&busyServers).(*Server)
				heap.Push(&availableServers, server)
			}
		}

		// Assign the current task to the best server
		server := heap.Pop(&availableServers).(*Server)
		server.available = i + tasks[i]
		heap.Push(&busyServers, server)
		result[i] = server.id
	}

	return result
}

type PriorityQueue []*Server

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].available < pq[j].available
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Server))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}
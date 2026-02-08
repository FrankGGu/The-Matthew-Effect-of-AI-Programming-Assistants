import (
	"container/heap"
	"sort"
)

type Server struct {
	index int
	weight int
	availableTime int
}

type AvailableServers []Server

func (h AvailableServers) Len() int {
	return len(h)
}

func (h AvailableServers) Less(i, j int) bool {
	if h[i].weight == h[j].weight {
		return h[i].index < h[j].index
	}
	return h[i].weight < h[j].weight
}

func (h AvailableServers) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *AvailableServers) Push(x interface{}) {
	*h = append(*h, x.(Server))
}

func (h *AvailableServers) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type BusyServers []Server

func (h BusyServers) Len() int {
	return len(h)
}

func (h BusyServers) Less(i, j int) bool {
	return h[i].availableTime < h[j].availableTime
}

func (h BusyServers) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *BusyServers) Push(x interface{}) {
	*h = append(*h, x.(Server))
}

func (h *BusyServers) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func assignTasks(servers []int, tasks []int) []int {
	n := len(servers)
	m := len(tasks)
	result := make([]int, m)

	availableServers := &AvailableServers{}
	heap.Init(availableServers)

	for i := 0; i < n; i++ {
		heap.Push(availableServers, Server{index: i, weight: servers[i], availableTime: 0})
	}

	busyServers := &BusyServers{}
	heap.Init(busyServers)

	for i := 0; i < m; i++ {
		for busyServers.Len() > 0 && busyServers.Len() > 0 && (*busyServers)[0].availableTime <= i {
			server := heap.Pop(busyServers).(Server)
			server.availableTime = 0
			heap.Push(availableServers, server)
		}

		if availableServers.Len() == 0 {
			nextAvailableTime := (*busyServers)[0].availableTime
			i = nextAvailableTime - 1
			continue
		}

		server := heap.Pop(availableServers).(Server)
		result[i] = server.index
		server.availableTime = i + tasks[i]
		heap.Push(busyServers, server)
	}

	return result
}

func main() {}
import "container/heap"

type Server struct {
	id      int
	time    int
}

type MinHeap []Server

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].time < h[j].time || (h[i].time == h[j].time && h[i].id < h[j].id) }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Server))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func assignTasks(servers []int, tasks []int) []int {
	n := len(servers)
	m := len(tasks)
	serverHeap := &MinHeap{}
	for i := 0; i < n; i++ {
		heap.Push(serverHeap, Server{id: i, time: 0})
	}
	result := make([]int, m)
	taskQueue := []int{}
	for i := 0; i < m; i++ {
		if len(taskQueue) == 0 {
			taskQueue = append(taskQueue, i)
		}
		if len(taskQueue) > 0 {
			for len(taskQueue) > 0 {
				taskIdx := taskQueue[0]
				if len(*serverHeap) == 0 {
					taskQueue = taskQueue[1:]
					break
				}
				server := heap.Pop(serverHeap).(Server)
				result[taskIdx] = server.id
				server.time += tasks[taskIdx]
				heap.Push(serverHeap, server)
				taskQueue = taskQueue[1:]
			}
		}
	}
	return result
}
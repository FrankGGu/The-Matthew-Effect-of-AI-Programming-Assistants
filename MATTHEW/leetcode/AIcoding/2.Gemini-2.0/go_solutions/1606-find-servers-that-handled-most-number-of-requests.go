import (
	"container/heap"
)

type server struct {
	index int
	count int
}

type availableHeap []int

func (h availableHeap) Len() int           { return len(h) }
func (h availableHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h availableHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *availableHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *availableHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type busyHeap struct {
	availableTime int
	serverIndex   int
}

type busyHeapType []busyHeap

func (h busyHeapType) Len() int           { return len(h) }
func (h busyHeapType) Less(i, j int) bool { return h[i].availableTime < h[j].availableTime }
func (h busyHeapType) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *busyHeapType) Push(x interface{}) {
	*h = append(*h, x.(busyHeap))
}

func (h *busyHeapType) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func busiestServers(k int, arrival []int, duration []int) []int {
	available := &availableHeap{}
	heap.Init(available)
	for i := 0; i < k; i++ {
		heap.Push(available, i)
	}

	busy := &busyHeapType{}
	heap.Init(busy)

	requests := make([]int, k)

	for i := 0; i < len(arrival); i++ {
		for busy.Len() > 0 && (*busy)[0].availableTime <= arrival[i] {
			serverIndex := heap.Pop(busy).(busyHeap).serverIndex
			heap.Push(available, serverIndex)
		}

		if available.Len() == 0 {
			continue
		}

		serverIndex := (arrival[i] - i%k + k) % k
		bestServer := -1

		tempAvailable := &availableHeap{}
		heap.Init(tempAvailable)

		found := false
		for available.Len() > 0 {
			s := heap.Pop(available).(int)
			if s >= serverIndex {
				bestServer = s
				found = true
				heap.Push(tempAvailable, s)
				break
			}
			heap.Push(tempAvailable, s)
		}

		for tempAvailable.Len() > 0 {
			heap.Push(available, heap.Pop(tempAvailable).(int))
		}

		if !found {
			bestServer = heap.Pop(available).(int)
		}

		heap.Push(busy, busyHeap{arrival[i] + duration[i], bestServer})
		requests[bestServer]++
	}

	maxRequests := 0
	for i := 0; i < k; i++ {
		if requests[i] > maxRequests {
			maxRequests = requests[i]
		}
	}

	result := []int{}
	for i := 0; i < k; i++ {
		if requests[i] == maxRequests {
			result = append(result, i)
		}
	}

	return result
}
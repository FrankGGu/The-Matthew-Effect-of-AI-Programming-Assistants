import (
	"container/heap"
	"sort"
)

type Server struct {
	index    int
	timeFree int
}

type MinHeap []Server

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].timeFree < h[j].timeFree }
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

func busiestServers(k int, arrival []int, load []int) []int {
	available := make([]int, 0, k)
	for i := 0; i < k; i++ {
		available = append(available, i)
	}
	busy := &MinHeap{}
	heap.Init(busy)
	count := make([]int, k)
	max := 0

	for i := 0; i < len(arrival); i++ {
		arrivalTime := arrival[i]
		for busy.Len() > 0 && (*busy)[0].timeFree <= arrivalTime {
			freed := heap.Pop(busy).(Server)
			available = append(available, freed.index)
		}

		if len(available) == 0 {
			continue
		}

		pos := sort.Search(len(available), func(j int) bool {
			return available[j] >= i%k
		})
		if pos == len(available) {
			pos = 0
		}
		selected := available[pos]
		available = append(available[:pos], available[pos+1:]...)
		count[selected]++
		if count[selected] > max {
			max = count[selected]
		}
		heap.Push(busy, Server{selected, arrivalTime + load[i]})
	}

	result := make([]int, 0)
	for i := 0; i < k; i++ {
		if count[i] == max {
			result = append(result, i)
		}
	}
	return result
}
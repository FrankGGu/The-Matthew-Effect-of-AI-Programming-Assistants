import (
	"container/heap"
	"sort"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func mincostToHireWorkers(quality []int, wage []int, k int) float64 {
	n := len(quality)
	workers := make([][2]float64, n)
	for i := 0; i < n; i++ {
		workers[i] = [2]float64{float64(wage[i]) / float64(quality[i]), float64(quality[i])}
	}
	sort.Slice(workers, func(i, j int) bool {
		return workers[i][0] < workers[j][0]
	})

	h := &MinHeap{}
	heap.Init(h)
	sumQ := 0.0
	res := 1e18

	for _, worker := range workers {
		ratio, q := worker[0], worker[1]
		sumQ += q
		heap.Push(h, int(q))
		if h.Len() > k {
			sumQ -= float64(heap.Pop(h).(int))
		}
		if h.Len() == k {
			if sumQ*ratio < res {
				res = sumQ * ratio
			}
		}
	}

	return res
}
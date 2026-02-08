import (
	"container/heap"
	"sort"
)

type Worker struct {
	ratio float64
	wage  int
	quality int
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func mincostToHireWorkers(quality []int, wage []int, k int) float64 {
	n := len(quality)
	workers := make([]Worker, n)
	for i := 0; i < n; i++ {
		workers[i] = Worker{float64(wage[i]) / float64(quality[i]), wage[i], quality[i]}
	}
	sort.Slice(workers, func(i, j int) bool {
		return workers[i].ratio < workers[j].ratio
	})

	h := &IntHeap{}
	heap.Init(h)
	sum := 0
	ans := float64(1e18)

	for _, worker := range workers {
		heap.Push(h, worker.quality)
		sum += worker.quality
		if h.Len() > k {
			sum -= heap.Pop(h).(int)
		}
		if h.Len() == k {
			ans = min(ans, worker.ratio*float64(sum))
		}
	}

	return ans
}

func min(a, b float64) float64 {
	if a < b {
		return a
	}
	return b
}
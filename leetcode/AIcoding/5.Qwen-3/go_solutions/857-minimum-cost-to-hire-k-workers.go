package main

func minCostToHireKWorkers(quality []int, wage []int, k int) int {
	type Worker struct {
		quality int
		wage    int
		ratio   float64
	}
	workers := make([]Worker, len(quality))
	for i := range quality {
		workers[i] = Worker{quality: quality[i], wage: wage[i], ratio: float64(wage[i]) / float64(quality[i])}
	}

	sort.Slice(workers, func(i, j int) bool {
		return workers[i].ratio < workers[j].ratio
	})

	maxHeap := &MaxHeap{}
	for i := 0; i < k; i++ {
		heap.Push(maxHeap, workers[i].quality)
	}

	totalQuality := 0
	for i := 0; i < k; i++ {
		totalQuality += workers[i].quality
	}

	minCost := totalQuality * int(workers[k-1].ratio)

	for i := k; i < len(workers); i++ {
		if workers[i].quality < (*maxHeap)[0] {
			totalQuality -= heap.Pop(maxHeap).(int)
			heap.Push(maxHeap, workers[i].quality)
			totalQuality += workers[i].quality
			cost := totalQuality * int(workers[i].ratio)
			if cost < minCost {
				minCost = cost
			}
		}
	}

	return minCost
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}
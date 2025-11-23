import (
	"container/heap"
	"sort"
)

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

func maxTaskAssign(tasks []int, workers []int, pills int, strength int) int {
	sort.Ints(tasks)
	sort.Ints(workers)

	left, right := 0, min(len(tasks), len(workers))
	answer := 0

	for left <= right {
		mid := (left + right) / 2
		if canAssign(tasks, workers, pills, strength, mid) {
			answer = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return answer
}

func canAssign(tasks []int, workers []int, pills int, strength int, k int) bool {
	if k == 0 {
		return true
	}
	if k > len(workers) {
		return false
	}

	workerHeap := make(IntHeap, 0)
	heap.Init(&workerHeap)

	i := len(workers) - 1
	for j := k - 1; j >= 0; j-- {
		for i >= len(workers)-k && workers[i] >= tasks[j] {
			heap.Push(&workerHeap, workers[i])
			i--
		}
		if workerHeap.Len() > 0 {
			heap.Pop(&workerHeap)
		} else if pills > 0 {
			pills--
			for i >= len(workers)-k && workers[i]+strength >= tasks[j] {
				heap.Push(&workerHeap, workers[i])
				i--
			}
			if workerHeap.Len() > 0 {
				heap.Pop(&workerHeap)
			} else {
				return false
			}
		} else {
			return false
		}
	}

	return true
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
import (
	"container/heap"
	"sort"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
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

func maxElegance(items [][]int, k int) int64 {
	sort.Slice(items, func(i, j int) bool {
		return items[i][0] > items[j][0]
	})

	var elegance int64
	duplicates := 0
	h := &IntHeap{}
	heap.Init(h)

	for i := 0; i < k; i++ {
		elegance += int64(items[i][0])
		if items[i][1] == 1 {
			duplicates++
		} else {
			heap.Push(h, items[i][0])
		}
	}

	ans := elegance + int64(duplicates)*int64(duplicates)

	for i := k; i < len(items); i++ {
		if items[i][1] == 1 {
			if h.Len() > 0 {
				smallest := heap.Pop(h).(int)
				elegance -= int64(smallest)
				elegance += int64(items[i][0])
				duplicates++
				ans = max(ans, elegance+int64(duplicates)*int64(duplicates))
			}
		}
	}

	return ans
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}
import (
	"container/heap"
)

type pair struct {
    i, j int
    sum  int
}

type minHeap []pair

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i].sum < h[j].sum }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *minHeap) Push(x interface{}) {
    *h = append(*h, x.(pair))
}

func (h *minHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func kSmallestPairs(nums1 []int, nums2 []int, k int) [][]int {
    if len(nums1) == 0 || len(nums2) == 0 || k == 0 {
        return [][]int{}
    }

    h := &minHeap{}
    heap.Init(h)

    for i := 0; i < len(nums1) && i < k; i++ {
        heap.Push(h, pair{i, 0, nums1[i] + nums2[0]})
    }

    res := [][]int{}
    for h.Len() > 0 && len(res) < k {
        p := heap.Pop(h).(pair)
        res = append(res, []int{nums1[p.i], nums2[p.j]})
        if p.j+1 < len(nums2) {
            heap.Push(h, pair{p.i, p.j + 1, nums1[p.i] + nums2[p.j+1]})
        }
    }

    return res
}
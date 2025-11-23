import (
	"container/heap"
)

type Pair struct {
    i, j int
    sum int
}

type MinHeap []Pair

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].sum < h[j].sum }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(Pair))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func kSmallestPairs(nums1 []int, nums2 []int, k int) [][]int {
    if len(nums1) == 0 || len(nums2) == 0 || k == 0 {
        return [][]int{}
    }

    h := &MinHeap{}
    heap.Init(h)

    for i := 0; i < len(nums1) && i < k; i++ {
        heap.Push(h, Pair{i, 0, nums1[i] + nums2[0]})
    }

    res := [][]int{}
    for h.Len() > 0 && len(res) < k {
        p := heap.Pop(h).(Pair)
        res = append(res, []int{nums1[p.i], nums2[p.j]})

        if p.j + 1 < len(nums2) {
            heap.Push(h, Pair{p.i, p.j + 1, nums1[p.i] + nums2[p.j + 1]})
        }
    }

    return res
}
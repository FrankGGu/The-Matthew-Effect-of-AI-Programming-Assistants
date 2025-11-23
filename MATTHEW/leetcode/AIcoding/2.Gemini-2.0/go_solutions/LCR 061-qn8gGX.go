import "container/heap"

type Pair struct {
    Sum   int
    Index1 int
    Index2 int
}

type PairHeap []Pair

func (h PairHeap) Len() int           { return len(h) }
func (h PairHeap) Less(i, j int) bool { return h[i].Sum < h[j].Sum }
func (h PairHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *PairHeap) Push(x interface{}) {
    *h = append(*h, x.(Pair))
}

func (h *PairHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func kSmallestPairs(nums1 []int, nums2 []int, k int) [][]int {
    if len(nums1) == 0 || len(nums2) == 0 {
        return [][]int{}
    }

    h := &PairHeap{}
    heap.Init(h)

    for i := 0; i < len(nums1) && i < k; i++ {
        heap.Push(h, Pair{Sum: nums1[i] + nums2[0], Index1: i, Index2: 0})
    }

    result := [][]int{}
    for i := 0; i < k && h.Len() > 0; i++ {
        pair := heap.Pop(h).(Pair)
        result = append(result, []int{nums1[pair.Index1], nums2[pair.Index2]})

        if pair.Index2+1 < len(nums2) {
            heap.Push(h, Pair{Sum: nums1[pair.Index1] + nums2[pair.Index2+1], Index1: pair.Index1, Index2: pair.Index2 + 1})
        }
    }

    return result
}
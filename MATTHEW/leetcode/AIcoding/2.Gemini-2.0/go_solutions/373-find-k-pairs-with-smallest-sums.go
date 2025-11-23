import "container/heap"

type Pair struct {
    i, j, sum int
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
    n1, n2 := len(nums1), len(nums2)
    if n1 == 0 || n2 == 0 {
        return [][]int{}
    }

    h := &MinHeap{}
    heap.Init(h)

    for i := 0; i < n1 && i < k; i++ {
        heap.Push(h, Pair{i: i, j: 0, sum: nums1[i] + nums2[0]})
    }

    result := [][]int{}
    for len(result) < k && h.Len() > 0 {
        pair := heap.Pop(h).(Pair)
        i, j := pair.i, pair.j
        result = append(result, []int{nums1[i], nums2[j]})

        if j+1 < n2 {
            heap.Push(h, Pair{i: i, j: j + 1, sum: nums1[i] + nums2[j+1]})
        }
    }

    return result
}
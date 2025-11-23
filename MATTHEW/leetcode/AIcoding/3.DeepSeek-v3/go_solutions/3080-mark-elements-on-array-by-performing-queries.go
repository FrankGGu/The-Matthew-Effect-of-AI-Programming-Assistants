func unmarkedSumArray(nums []int, queries [][]int) []int64 {
    n := len(nums)
    marked := make([]bool, n)
    sum := int64(0)
    for _, num := range nums {
        sum += int64(num)
    }

    type pair struct {
        val int
        idx int
    }
    minHeap := make([]pair, 0, n)
    for i, num := range nums {
        minHeap = append(minHeap, pair{num, i})
    }
    heap.Init(&minHeap)

    res := make([]int64, len(queries))
    for i, query := range queries {
        index, k := query[0], query[1]
        if !marked[index] {
            marked[index] = true
            sum -= int64(nums[index])
        }

        for k > 0 && len(minHeap) > 0 {
            for len(minHeap) > 0 && marked[minHeap[0].idx] {
                heap.Pop(&minHeap)
            }
            if len(minHeap) == 0 {
                break
            }
            p := heap.Pop(&minHeap).(pair)
            marked[p.idx] = true
            sum -= int64(p.val)
            k--
        }
        res[i] = sum
    }
    return res
}

type MinHeap []pair

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].val < h[j].val || (h[i].val == h[j].val && h[i].idx < h[j].idx) }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.(pair)) }
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}
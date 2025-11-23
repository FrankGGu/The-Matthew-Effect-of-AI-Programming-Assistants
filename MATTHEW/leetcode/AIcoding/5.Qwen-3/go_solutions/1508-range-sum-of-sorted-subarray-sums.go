package main

func rangeSum(nums []int, n int, left int, right int) int {
    mod := 1000000007
    minHeap := make([]int, 0)
    for i := 0; i < n; i++ {
        heap.Push(&minHeap, []int{nums[i], i})
    }
    result := 0
    for i := 1; i <= right; i++ {
        val := heap.Pop(&minHeap).([]int)
        if i >= left {
            result = (result + val[0]) % mod
        }
        if val[1]+1 < n {
            heap.Push(&minHeap, []int{(val[0] + nums[val[1]+1]) % mod, val[1] + 1})
        }
    }
    return result
}

type IntHeap [][]int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
    *h = append(*h, x.([]int))
}

func (h *IntHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}
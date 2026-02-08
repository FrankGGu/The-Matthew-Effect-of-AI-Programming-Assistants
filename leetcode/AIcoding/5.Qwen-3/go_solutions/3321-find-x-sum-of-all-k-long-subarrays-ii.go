package main

func kSum(ints []int, k int) int {
    n := len(ints)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + ints[i]
    }

    minHeap := make([]int, 0)
    for i := 0; i < n-k+1; i++ {
        sum := prefix[i+k] - prefix[i]
        minHeap = append(minHeap, sum)
    }
    heap.Init(&minHeap)

    for len(minHeap) > k {
        heap.Pop(&minHeap)
    }

    return minHeap[0]
}

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
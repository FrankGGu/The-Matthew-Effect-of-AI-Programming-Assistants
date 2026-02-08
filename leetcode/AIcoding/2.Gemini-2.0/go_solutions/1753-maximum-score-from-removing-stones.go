import "container/heap"

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

func maximumScore(a int, b int, c int) int {
    h := &IntHeap{a, b, c}
    heap.Init(h)

    score := 0
    for h.Len() > 1 {
        x := heap.Pop(h).(int)
        y := heap.Pop(h).(int)

        score += y
        x--

        if x > 0 {
            heap.Push(h, x)
        }
    }

    return score
}
import "container/heap"

type Point struct {
    x, y int
}

type MinHeap []Point

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].x*h[i].x+h[i].y*h[i].y < h[j].x*h[j].x+h[j].y*h[j].y }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(Point))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func kClosest(points [][]int, k int) [][]int {
    h := &MinHeap{}
    heap.Init(h)
    for _, p := range points {
        heap.Push(h, Point{p[0], p[1]})
        if h.Len() > k {
            heap.Pop(h)
        }
    }
    result := make([][]int, k)
    for i := 0; i < k; i++ {
        p := heap.Pop(h).(Point)
        result[i] = []int{p.x, p.y}
    }
    return result
}
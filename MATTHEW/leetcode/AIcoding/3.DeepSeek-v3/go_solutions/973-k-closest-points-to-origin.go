import (
    "container/heap"
    "math"
)

type Point struct {
    x, y int
    dist float64
}

type MaxHeap []Point

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].dist > h[j].dist }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(Point))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func kClosest(points [][]int, k int) [][]int {
    h := &MaxHeap{}
    heap.Init(h)

    for _, p := range points {
        dist := math.Sqrt(float64(p[0]*p[0] + p[1]*p[1]))
        point := Point{p[0], p[1], dist}
        heap.Push(h, point)
        if h.Len() > k {
            heap.Pop(h)
        }
    }

    res := make([][]int, k)
    for i := 0; i < k; i++ {
        point := heap.Pop(h).(Point)
        res[i] = []int{point.x, point.y}
    }

    return res
}
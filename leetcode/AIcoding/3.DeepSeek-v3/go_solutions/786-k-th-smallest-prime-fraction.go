import (
	"container/heap"
)

type Fraction struct {
	numerator   int
	denominator int
	value       float64
}

type MinHeap []Fraction

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].value < h[j].value }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Fraction))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func kthSmallestPrimeFraction(arr []int, k int) []int {
	n := len(arr)
	h := &MinHeap{}
	heap.Init(h)

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			fraction := Fraction{
				numerator:   arr[i],
				denominator: arr[j],
				value:       float64(arr[i]) / float64(arr[j]),
			}
			heap.Push(h, fraction)
		}
	}

	var result Fraction
	for i := 0; i < k; i++ {
		result = heap.Pop(h).(Fraction)
	}

	return []int{result.numerator, result.denominator}
}
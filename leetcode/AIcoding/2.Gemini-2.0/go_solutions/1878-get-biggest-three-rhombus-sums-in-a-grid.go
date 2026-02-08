import (
	"container/heap"
)

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

func getBiggestThree(grid [][]int) []int {
	m, n := len(grid), len(grid[0])
	sums := make(map[int]bool)
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			sums[grid[i][j]] = true
			for k := 1; i-k >= 0 && i+k < m && j-k >= 0 && j+k < n; k++ {
				sum := 0
				for l := 0; l <= k; l++ {
					sum += grid[i-k+l][j+l]
					sum += grid[i-k+l][j-l]
					sum += grid[i+k-l][j+l]
					sum += grid[i+k-l][j-l]
				}
				sum -= grid[i-k][j+k]
				sum -= grid[i-k][j-k]
				sum -= grid[i+k][j+k]
				sum -= grid[i+k][j-k]
				sums[sum] = true
			}
		}
	}

	h := &IntHeap{}
	heap.Init(h)

	for sum := range sums {
		heap.Push(h, sum)
		if h.Len() > 3 {
			heap.Pop(h)
		}
	}

	result := make([]int, 0)
	for h.Len() > 0 {
		result = append([]int{heap.Pop(h).(int)}, result...)
	}

	return result
}
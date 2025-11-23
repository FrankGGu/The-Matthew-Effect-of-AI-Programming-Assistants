import (
	"container/heap"
)

type MinHeap [][]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.([]int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func kthSmallest(mat [][]int, k int) int {
	m := len(mat)
	n := len(mat[0])

	current := []int{0}
	for i := 0; i < m; i++ {
		next := []int{}
		h := &MinHeap{}
		heap.Init(h)
		for _, sum := range current {
			for j := 0; j < n; j++ {
				heap.Push(h, []int{sum + mat[i][j], j, 0})
			}
		}
		seen := make(map[string]bool)
		for len(next) < k && h.Len() > 0 {
			curr := heap.Pop(h).([]int)
			sum, j, _ := curr[0], curr[1], curr[2]
			key := string(sum) + "," + string(j)
			if !seen[key] {
				seen[key] = true
				next = append(next, sum)
			}
		}
		current = next
		if len(current) == 0 {
			return -1
		}
	}
	if k > len(current) {
		return current[len(current)-1]
	}
	return current[k-1]
}
import "container/heap"

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

func maxStarSum(vals []int, edges [][]int, k int) int {
	n := len(vals)
	adj := make([][]int, n)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	maxSum := -100001
	for i := 0; i < n; i++ {
		h := &IntHeap{}
		heap.Init(h)

		for _, neighbor := range adj[i] {
			if vals[neighbor] > 0 {
				heap.Push(h, vals[neighbor])
				if h.Len() > k {
					heap.Pop(h)
				}
			}
		}

		currentSum := vals[i]
		temp := IntHeap{}
		for h.Len() > 0 {
			val := heap.Pop(h).(int)
			currentSum += val
			temp = append(temp, val)
		}

		if currentSum > maxSum {
			maxSum = currentSum
		}
	}

	return maxSum
}
import (
	"container/heap"
	"sort"
)

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

func maxTotalDamage(damage []int, cost []int, armor int) int64 {
	n := len(damage)
	items := make([][]int, n)
	for i := 0; i < n; i++ {
		items[i] = []int{damage[i], cost[i]}
	}

	sort.Slice(items, func(i, j int) bool {
		return items[i][1] < items[j][1]
	})

	sum := 0
	maxDamage := 0
	for _, d := range damage {
		sum += d
		if d > maxDamage {
			maxDamage = d
		}
	}

	ans := 0
	h := &IntHeap{}
	heap.Init(h)
	totalDamage := 0
	totalCost := 0
	for i := 0; i < n; i++ {
		d := items[i][0]
		c := items[i][1]
		totalDamage += d
		totalCost += c
		heap.Push(h, d)

		for totalCost > armor {
			totalDamage -= heap.Pop().(int)
			totalCost -= c
		}

		ans = max(ans, totalDamage)
	}

	return int64(ans)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
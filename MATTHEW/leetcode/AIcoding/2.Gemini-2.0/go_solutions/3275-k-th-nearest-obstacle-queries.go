import (
	"container/heap"
	"math"
)

func kthNearestObstacle(grid [][]int, queries [][]int, k int) []int {
	n := len(grid)
	m := len(grid[0])
	obstacles := []struct{ x, y int }{}
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if grid[i][j] == 1 {
				obstacles = append(obstacles, struct{ x, y int }{i, j})
			}
		}
	}

	ans := make([]int, len(queries))
	for i, q := range queries {
		x, y := q[0], q[1]
		pq := &PriorityQueue{}
		heap.Init(pq)

		for j, obs := range obstacles {
			dist := abs(x-obs.x) + abs(y-obs.y)
			heap.Push(pq, &Item{value: j, priority: dist})
		}

		if pq.Len() < k {
			ans[i] = -1
		} else {
			for l := 0; l < k-1; l++ {
				heap.Pop(pq)
			}
			item := heap.Pop(pq).(*Item)
			ans[i] = item.value
		}
	}

	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

type Item struct {
	value    int
	priority int
	index    int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].priority < pq[j].priority
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *PriorityQueue) Push(x interface{}) {
	n := len(*pq)
	item := x.(*Item)
	item.index = n
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil
	item.index = -1
	*pq = old[0 : n-1]
	return item
}

func (pq *PriorityQueue) update(item *Item, value int, priority int) {
	item.value = value
	item.priority = priority
	heap.Fix(pq, item.index)
}
import (
	"container/heap"
	"math"
)

type Edge struct {
	x, y, effort int
}

type PriorityQueue []Edge

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].effort < pq[j].effort
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Edge)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minimumEffortPath(heights [][]int) int {
	m, n := len(heights), len(heights[0])
	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32
		}
	}
	dist[0][0] = 0
	pq := &PriorityQueue{{0, 0, 0}}
	heap.Init(pq)

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Edge)
		x, y, effort := curr.x, curr.y, curr.effort

		if effort > dist[x][y] {
			continue
		}

		for _, dir := range dirs {
			nx, ny := x+dir[0], y+dir[1]
			if nx >= 0 && nx < m && ny >= 0 && ny < n {
				newEffort := int(math.Max(float64(effort), math.Abs(float64(heights[x][y]-heights[nx][ny]))))
				if newEffort < dist[nx][ny] {
					dist[nx][ny] = newEffort
					heap.Push(pq, Edge{nx, ny, newEffort})
				}
			}
		}
	}

	return dist[m-1][n-1]
}
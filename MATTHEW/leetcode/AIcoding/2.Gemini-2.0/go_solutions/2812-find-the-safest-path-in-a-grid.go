import (
	"container/heap"
)

func maximumSafenessFactor(grid [][]int) int {
	n := len(grid)
	dists := make([][]int, n)
	for i := range dists {
		dists[i] = make([]int, n)
	}

	q := make([][2]int, 0)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				q = append(q, [2]int{i, j})
				dists[i][j] = 0
			} else {
				dists[i][j] = -1
			}
		}
	}

	dirs := [][2]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		x, y := curr[0], curr[1]

		for _, dir := range dirs {
			nx, ny := x+dir[0], y+dir[1]
			if nx >= 0 && nx < n && ny >= 0 && ny < n && dists[nx][ny] == -1 {
				dists[nx][ny] = dists[x][y] + 1
				q = append(q, [2]int{nx, ny})
			}
		}
	}

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &Item{row: 0, col: 0, safeness: dists[0][0]})

	visited := make([][]bool, n)
	for i := range visited {
		visited[i] = make([]bool, n)
	}
	visited[0][0] = true

	maxSafeness := 0
	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		x, y, safeness := item.row, item.col, item.safeness

		if x == n-1 && y == n-1 {
			maxSafeness = safeness
			break
		}

		for _, dir := range dirs {
			nx, ny := x+dir[0], y+dir[1]
			if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] {
				visited[nx][ny] = true
				newSafeness := min(safeness, dists[nx][ny])
				heap.Push(pq, &Item{row: nx, col: ny, safeness: newSafeness})
			}
		}
	}

	return maxSafeness
}

type Item struct {
	row      int
	col      int
	safeness int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].safeness > pq[j].safeness
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
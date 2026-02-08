import (
	"container/heap"
)

type cell struct {
	x, y, height int
}

type priorityQueue []cell

func (pq priorityQueue) Len() int {
	return len(pq)
}

func (pq priorityQueue) Less(i, j int) bool {
	return pq[i].height < pq[j].height
}

func (pq priorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *priorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(cell))
}

func (pq *priorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func trapRainWater(heights [][]int) int {
	if len(heights) == 0 || len(heights[0]) == 0 {
		return 0
	}

	m := len(heights)
	n := len(heights[0])

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	pq := &priorityQueue{}
	heap.Init(pq)

	for i := 0; i < m; i++ {
		heap.Push(pq, cell{i, 0, heights[i][0]})
		heap.Push(pq, cell{i, n - 1, heights[i][n-1]})
		visited[i][0] = true
		visited[i][n-1] = true
	}

	for j := 1; j < n-1; j++ {
		heap.Push(pq, cell{0, j, heights[0][j]})
		heap.Push(pq, cell{m - 1, j, heights[m-1][j]})
		visited[0][j] = true
		visited[m-1][j] = true
	}

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	water := 0

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(cell)
		x, y, height := curr.x, curr.y, curr.height

		for _, dir := range dirs {
			nx, ny := x+dir[0], y+dir[1]

			if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] {
				visited[nx][ny] = true

				if heights[nx][ny] < height {
					water += height - heights[nx][ny]
					heap.Push(pq, cell{nx, ny, height})
				} else {
					heap.Push(pq, cell{nx, ny, heights[nx][ny]})
				}
			}
		}
	}

	return water
}
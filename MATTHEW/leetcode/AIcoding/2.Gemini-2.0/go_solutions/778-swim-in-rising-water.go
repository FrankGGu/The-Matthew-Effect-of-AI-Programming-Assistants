import "container/heap"

type Node struct {
	x, y, height int
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].height < pq[j].height
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(Node))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func swimInWater(grid [][]int) int {
	n := len(grid)
	visited := make([][]bool, n)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	pq := &PriorityQueue{{0, 0, grid[0][0]}}
	heap.Init(pq)
	visited[0][0] = true
	ans := 0

	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for {
		node := heap.Pop(pq).(Node)
		ans = max(ans, node.height)

		if node.x == n-1 && node.y == n-1 {
			return ans
		}

		for _, dir := range directions {
			nx, ny := node.x+dir[0], node.y+dir[1]
			if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] {
				visited[nx][ny] = true
				heap.Push(pq, Node{nx, ny, grid[nx][ny]})
			}
		}
	}
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
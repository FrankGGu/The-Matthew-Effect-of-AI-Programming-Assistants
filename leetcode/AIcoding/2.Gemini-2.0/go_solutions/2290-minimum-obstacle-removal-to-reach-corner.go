import (
	"container/heap"
)

type Item struct {
	row   int
	col   int
	cost  int
	index int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].cost < pq[j].cost
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
	old[n-1] = nil  // avoid memory leak
	item.index = -1 // for safety
	*pq = old[0 : n-1]
	return item
}

func minimumObstacleRemoval(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = 1000000000
		}
	}
	dist[0][0] = 0

	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &Item{row: 0, col: 0, cost: 0})

	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*Item)
		row := item.row
		col := item.col
		cost := item.cost

		if cost > dist[row][col] {
			continue
		}

		for _, dir := range directions {
			newRow := row + dir[0]
			newCol := col + dir[1]

			if newRow >= 0 && newRow < m && newCol >= 0 && newCol < n {
				newCost := cost + grid[newRow][newCol]
				if newCost < dist[newRow][newCol] {
					dist[newRow][newCol] = newCost
					heap.Push(&pq, &Item{row: newRow, col: newCol, cost: newCost})
				}
			}
		}
	}

	return dist[m-1][n-1]
}
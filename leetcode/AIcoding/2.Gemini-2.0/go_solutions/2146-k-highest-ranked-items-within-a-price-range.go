import (
	"container/heap"
	"sort"
)

type Item struct {
	Distance int
	Price    int
	Row      int
	Col      int
}

type PriorityQueue []Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].Distance != pq[j].Distance {
		return pq[i].Distance < pq[j].Distance
	}
	if pq[i].Price != pq[j].Price {
		return pq[i].Price < pq[j].Price
	}
	if pq[i].Row != pq[j].Row {
		return pq[i].Row < pq[j].Row
	}
	return pq[i].Col < pq[j].Col
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func highestRankedKItems(grid [][]int, pricing []int, start []int, k int) [][]int {
	rows := len(grid)
	cols := len(grid[0])
	pq := &PriorityQueue{}
	heap.Init(pq)

	visited := make([][]bool, rows)
	for i := range visited {
		visited[i] = make([]bool, cols)
	}

	queue := [][]int{start}
	visited[start[0]][start[1]] = true
	distance := 0

	for len(queue) > 0 {
		newQueue := [][]int{}
		for _, curr := range queue {
			row := curr[0]
			col := curr[1]

			if grid[row][col] >= pricing[0] && grid[row][col] <= pricing[1] {
				heap.Push(pq, Item{
					Distance: distance,
					Price:    grid[row][col],
					Row:      row,
					Col:      col,
				})
			}
		}

		for len(queue) > 0 {
			curr := queue[0]
			queue = queue[1:]
			row := curr[0]
			col := curr[1]

			directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
			for _, dir := range directions {
				newRow := row + dir[0]
				newCol := col + dir[1]

				if newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] != 0 && !visited[newRow][newCol] {
					newQueue = append(newQueue, []int{newRow, newCol})
					visited[newRow][newCol] = true
				}
			}
		}
		queue = newQueue
		distance++
	}

	result := [][]int{}
	for i := 0; i < k && pq.Len() > 0; i++ {
		item := heap.Pop(pq).(Item)
		result = append(result, []int{item.Row, item.Col})
	}

	return result
}
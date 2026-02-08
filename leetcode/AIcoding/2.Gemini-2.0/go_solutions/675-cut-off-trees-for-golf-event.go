import (
	"container/heap"
	"sort"
)

type Point struct {
	X, Y int
}

func cutOffTree(forest [][]int) int {
	trees := []Point{}
	for i := 0; i < len(forest); i++ {
		for j := 0; j < len(forest[0]); j++ {
			if forest[i][j] > 1 {
				trees = append(trees, Point{i, j})
			}
		}
	}

	sort.Slice(trees, func(i, j int) bool {
		return forest[trees[i].X][trees[i].Y] < forest[trees[j].X][trees[j].Y]
	})

	start := Point{0, 0}
	totalSteps := 0
	for _, tree := range trees {
		steps := bfs(forest, start, tree)
		if steps == -1 {
			return -1
		}
		totalSteps += steps
		start = tree
	}

	return totalSteps
}

func bfs(forest [][]int, start, end Point) int {
	rows := len(forest)
	cols := len(forest[0])
	visited := make([][]bool, rows)
	for i := range visited {
		visited[i] = make([]bool, cols)
	}

	queue := []Point{start}
	visited[start.X][start.Y] = true
	steps := 0
	directions := []Point{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for len(queue) > 0 {
		size := len(queue)
		for i := 0; i < size; i++ {
			curr := queue[0]
			queue = queue[1:]

			if curr == end {
				return steps
			}

			for _, dir := range directions {
				nextX := curr.X + dir.X
				nextY := curr.Y + dir.Y

				if nextX >= 0 && nextX < rows && nextY >= 0 && nextY < cols &&
					forest[nextX][nextY] != 0 && !visited[nextX][nextY] {
					queue = append(queue, Point{nextX, nextY})
					visited[nextX][nextY] = true
				}
			}
		}
		steps++
	}

	return -1
}

type Item struct {
	X, Y, Dist int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Dist < pq[j].Dist
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
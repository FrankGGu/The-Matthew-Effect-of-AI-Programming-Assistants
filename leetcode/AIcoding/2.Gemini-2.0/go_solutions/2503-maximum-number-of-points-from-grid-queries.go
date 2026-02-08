import (
	"container/heap"
	"sort"
)

type Point struct {
	X int
	Y int
	Val int
}

type PriorityQueue []Point

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Val < pq[j].Val
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Point)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func maxPoints(grid [][]int, queries []int) []int {
	m := len(grid)
	n := len(grid[0])
	qLen := len(queries)
	ans := make([]int, qLen)

	type Query struct {
		Index int
		Value int
	}

	queriesWithIndex := make([]Query, qLen)
	for i := 0; i < qLen; i++ {
		queriesWithIndex[i] = Query{Index: i, Value: queries[i]}
	}

	sort.Slice(queriesWithIndex, func(i, j int) bool {
		return queriesWithIndex[i].Value < queriesWithIndex[j].Value
	})

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, Point{X: 0, Y: 0, Val: grid[0][0]})
	visited[0][0] = true

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	count := 0

	for _, query := range queriesWithIndex {
		for pq.Len() > 0 && (*pq)[0].Val < query.Value {
			curr := heap.Pop(pq).(Point)
			count++

			for _, dir := range dirs {
				newX := curr.X + dir[0]
				newY := curr.Y + dir[1]

				if newX >= 0 && newX < m && newY >= 0 && newY < n && !visited[newX][newY] {
					heap.Push(pq, Point{X: newX, Y: newY, Val: grid[newX][newY]})
					visited[newX][newY] = true
				}
			}
		}
		ans[query.Index] = count
	}

	return ans
}
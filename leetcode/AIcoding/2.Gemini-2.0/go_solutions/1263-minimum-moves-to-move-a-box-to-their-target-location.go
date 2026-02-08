import (
	"container/heap"
)

type state struct {
	px, py, bx, by, moves int
}

type priorityQueue []state

func (pq priorityQueue) Len() int { return len(pq) }
func (pq priorityQueue) Less(i, j int) bool {
	return pq[i].moves < pq[j].moves
}
func (pq priorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *priorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(state))
}

func (pq *priorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func minPushBox(grid [][]byte) int {
	m, n := len(grid), len(grid[0])
	var px, py, bx, by, tx, ty int
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 'S' {
				px, py = i, j
			} else if grid[i][j] == 'B' {
				bx, by = i, j
			} else if grid[i][j] == 'T' {
				tx, ty = i, j
			}
		}
	}

	visited := make(map[int]map[int]map[int]map[int]bool)
	pq := &priorityQueue{state{px, py, bx, by, 0}}
	heap.Init(pq)

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(state)
		px, py, bx, by, moves := curr.px, curr.py, curr.bx, curr.by, curr.moves

		if bx == tx && by == ty {
			return moves
		}

		if _, ok := visited[px]; !ok {
			visited[px] = make(map[int]map[int]map[int]bool)
		}
		if _, ok := visited[px][py]; !ok {
			visited[px][py] = make(map[int]map[int]bool)
		}
		if _, ok := visited[px][py][bx]; !ok {
			visited[px][py][bx] = make(map[int]bool)
		}
		if visited[px][py][bx][by] {
			continue
		}
		visited[px][py][bx][by] = true

		for _, dir := range dirs {
			dx, dy := dir[0], dir[1]
			npx, npy := px+dx, py+dy

			if npx >= 0 && npx < m && npy >= 0 && npy < n && grid[npx][npy] != '#' {
				if npx == bx && npy == by {
					nbx, nby := bx+dx, by+dy
					if nbx >= 0 && nbx < m && nby >= 0 && nby < n && grid[nbx][nby] != '#' {
						heap.Push(pq, state{bx, by, nbx, nby, moves + 1})
					}
				} else {
					heap.Push(pq, state{npx, npy, bx, by, moves})
				}
			}
		}
	}

	return -1
}
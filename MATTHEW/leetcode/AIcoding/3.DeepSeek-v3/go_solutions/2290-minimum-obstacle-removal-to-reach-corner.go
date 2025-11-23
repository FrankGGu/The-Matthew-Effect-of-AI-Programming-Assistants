type Cell struct {
    i, j, obstacles int
}

func minimumObstacles(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = math.MaxInt32
        }
    }
    dist[0][0] = 0
    heap := &MinHeap{}
    heap.Push(Cell{0, 0, 0})

    for heap.Len() > 0 {
        curr := heap.Pop().(Cell)
        if curr.i == m-1 && curr.j == n-1 {
            return curr.obstacles
        }
        if curr.obstacles > dist[curr.i][curr.j] {
            continue
        }
        for _, d := range dirs {
            ni, nj := curr.i+d[0], curr.j+d[1]
            if ni >= 0 && ni < m && nj >= 0 && nj < n {
                newObstacles := curr.obstacles + grid[ni][nj]
                if newObstacles < dist[ni][nj] {
                    dist[ni][nj] = newObstacles
                    heap.Push(Cell{ni, nj, newObstacles})
                }
            }
        }
    }
    return dist[m-1][n-1]
}

type MinHeap []Cell

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].obstacles < h[j].obstacles }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(Cell))
}
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}
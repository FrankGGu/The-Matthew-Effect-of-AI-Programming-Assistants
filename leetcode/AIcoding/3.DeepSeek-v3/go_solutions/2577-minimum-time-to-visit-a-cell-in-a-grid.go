type Cell struct {
    i, j, time int
}

type MinHeap []Cell

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].time < h[j].time }
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

func minimumTime(grid [][]int) int {
    if grid[0][1] > 1 && grid[1][0] > 1 {
        return -1
    }

    m, n := len(grid), len(grid[0])
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make([][]int, m)
    for i := range visited {
        visited[i] = make([]int, n)
        for j := range visited[i] {
            visited[i][j] = math.MaxInt32
        }
    }

    pq := &MinHeap{}
    heap.Init(pq)
    heap.Push(pq, Cell{0, 0, 0})
    visited[0][0] = 0

    for pq.Len() > 0 {
        curr := heap.Pop(pq).(Cell)
        if curr.i == m-1 && curr.j == n-1 {
            return curr.time
        }
        for _, d := range dirs {
            ni, nj := curr.i+d[0], curr.j+d[1]
            if ni < 0 || ni >= m || nj < 0 || nj >= n {
                continue
            }
            nextTime := curr.time + 1
            if grid[ni][nj] > nextTime {
                diff := grid[ni][nj] - nextTime
                if diff%2 == 0 {
                    nextTime = grid[ni][nj]
                } else {
                    nextTime = grid[ni][nj] + 1
                }
            }
            if nextTime < visited[ni][nj] {
                visited[ni][nj] = nextTime
                heap.Push(pq, Cell{ni, nj, nextTime})
            }
        }
    }
    return -1
}
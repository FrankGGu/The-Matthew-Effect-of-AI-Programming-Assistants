type Cell struct {
    x, y, effort int
}

type MinHeap []Cell

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].effort < h[j].effort }
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

func minimumEffortPath(heights [][]int) int {
    rows := len(heights)
    if rows == 0 {
        return 0
    }
    cols := len(heights[0])
    if cols == 0 {
        return 0
    }

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    efforts := make([][]int, rows)
    for i := range efforts {
        efforts[i] = make([]int, cols)
        for j := range efforts[i] {
            efforts[i][j] = math.MaxInt32
        }
    }
    efforts[0][0] = 0

    minHeap := &MinHeap{}
    heap.Push(minHeap, Cell{0, 0, 0})

    for minHeap.Len() > 0 {
        cell := heap.Pop(minHeap).(Cell)
        x, y, currentEffort := cell.x, cell.y, cell.effort

        if x == rows-1 && y == cols-1 {
            return currentEffort
        }

        if currentEffort > efforts[x][y] {
            continue
        }

        for _, dir := range dirs {
            nx, ny := x+dir[0], y+dir[1]
            if nx >= 0 && nx < rows && ny >= 0 && ny < cols {
                newEffort := max(currentEffort, abs(heights[x][y]-heights[nx][ny]))
                if newEffort < efforts[nx][ny] {
                    efforts[nx][ny] = newEffort
                    heap.Push(minHeap, Cell{nx, ny, newEffort})
                }
            }
        }
    }
    return -1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}
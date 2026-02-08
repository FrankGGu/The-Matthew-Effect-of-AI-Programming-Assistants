import (
    "container/heap"
)

type Cell struct {
    row, col, height int
}

type MinHeap []Cell

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].height < h[j].height }
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

func trapRainWater(heightMap [][]int) int {
    if len(heightMap) == 0 || len(heightMap[0]) == 0 {
        return 0
    }
    m, n := len(heightMap), len(heightMap[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    h := &MinHeap{}
    heap.Init(h)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i == 0 || i == m-1 || j == 0 || j == n-1 {
                heap.Push(h, Cell{i, j, heightMap[i][j]})
                visited[i][j] = true
            }
        }
    }

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    res := 0
    for h.Len() > 0 {
        cell := heap.Pop(h).(Cell)
        for _, dir := range dirs {
            row := cell.row + dir[0]
            col := cell.col + dir[1]
            if row >= 0 && row < m && col >= 0 && col < n && !visited[row][col] {
                visited[row][col] = true
                res += max(0, cell.height - heightMap[row][col])
                heap.Push(h, Cell{row, col, max(heightMap[row][col], cell.height)})
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
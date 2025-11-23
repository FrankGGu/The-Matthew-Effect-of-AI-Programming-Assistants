type MinHeap [][3]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.([3]int))
}
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func maxPoints(grid [][]int, queries []int) []int {
    m, n := len(grid), len(grid[0])
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    res := make([]int, len(queries))
    queriesWithIndices := make([][2]int, len(queries))
    for i, q := range queries {
        queriesWithIndices[i] = [2]int{q, i}
    }
    sort.Slice(queriesWithIndices, func(i, j int) bool {
        return queriesWithIndices[i][0] < queriesWithIndices[j][0]
    })

    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    h := &MinHeap{}
    heap.Push(h, [3]int{grid[0][0], 0, 0})
    visited[0][0] = true
    count := 0

    for _, query := range queriesWithIndices {
        q, idx := query[0], query[1]
        for h.Len() > 0 && (*h)[0][0] < q {
            cell := heap.Pop(h).([3]int)
            val, i, j := cell[0], cell[1], cell[2]
            count++
            for _, dir := range dirs {
                ni, nj := i+dir[0], j+dir[1]
                if ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj] {
                    visited[ni][nj] = true
                    heap.Push(h, [3]int{grid[ni][nj], ni, nj})
                }
            }
        }
        res[idx] = count
    }
    return res
}
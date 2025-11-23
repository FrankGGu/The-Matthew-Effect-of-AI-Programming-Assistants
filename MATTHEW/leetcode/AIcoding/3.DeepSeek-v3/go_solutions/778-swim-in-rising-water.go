import (
    "container/heap"
)

type MinHeap [][]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.([]int))
}
func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[:n-1]
    return x
}

func swimInWater(grid [][]int) int {
    n := len(grid)
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    minHeap := &MinHeap{}
    heap.Push(minHeap, []int{grid[0][0], 0, 0})
    visited[0][0] = true
    maxTime := 0

    for minHeap.Len() > 0 {
        current := heap.Pop(minHeap).([]int)
        time, x, y := current[0], current[1], current[2]
        if time > maxTime {
            maxTime = time
        }
        if x == n-1 && y == n-1 {
            return maxTime
        }
        for _, dir := range directions {
            nx, ny := x+dir[0], y+dir[1]
            if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] {
                visited[nx][ny] = true
                heap.Push(minHeap, []int{grid[nx][ny], nx, ny})
            }
        }
    }
    return maxTime
}
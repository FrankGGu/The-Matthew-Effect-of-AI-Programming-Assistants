import "container/heap"

type Cell struct {
    x, y, time int
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

func minTimeToVisitCell(grid [][]int, start []int, target []int) int {
    m, n := len(grid), len(grid[0])
    directions := []struct{ x, y int }{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    pq := &MinHeap{}
    heap.Init(pq)
    heap.Push(pq, Cell{start[0], start[1], 0})
    visited := make(map[[2]int]bool)

    for pq.Len() > 0 {
        cell := heap.Pop(pq).(Cell)
        if cell.x == target[0] && cell.y == target[1] {
            return cell.time
        }
        if visited[[2]int{cell.x, cell.y}] {
            continue
        }
        visited[[2]int{cell.x, cell.y}] = true

        for _, d := range directions {
            nx, ny := cell.x+d.x, cell.y+d.y
            if nx >= 0 && nx < m && ny >= 0 && ny < n {
                waitTime := max(0, grid[nx][ny]-cell.time)
                heap.Push(pq, Cell{nx, ny, cell.time + waitTime + 1})
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
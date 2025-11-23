package main

func swimInWater(grid [][]int) int {
    n := len(grid)
    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    heap := &Heap{}
    heap.Push(&Item{grid[0][0], 0, 0})
    visited[0][0] = true
    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    max := grid[0][0]
    for heap.Len() > 0 {
        item := heap.Pop().(*Item)
        if item.x == n-1 && item.y == n-1 {
            return item.value
        }
        for _, dir := range directions {
            nx, ny := item.x+dir[0], item.y+dir[1]
            if nx >= 0 && ny >= 0 && nx < n && ny < n && !visited[nx][ny] {
                visited[nx][ny] = true
                heap.Push(&Item{grid[nx][ny], nx, ny})
                if grid[nx][ny] > max {
                    max = grid[nx][ny]
                }
            }
        }
    }
    return max
}

type Item struct {
    value int
    x     int
    y     int
}

type Heap []*Item

func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i].value < h[j].value }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Heap) Push(x interface{}) {
    *h = append(*h, x.(*Item))
}

func (h *Heap) Pop() interface{} {
    old := *h
    n := len(old)
    item := old[n-1]
    old[n-1] = nil
    *h = old[0 : n-1]
    return item
}
package main

import (
    "container/heap"
)

type Point struct {
    x, y, danger int
}

type MaxHeap []Point

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].danger > h[j].danger }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(Point))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func maximumSafeness(grid [][]int) int {
    n, m := len(grid), len(grid[0])
    dir := [][2]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}
    danger := make([][]int, n)
    for i := range danger {
        danger[i] = make([]int, m)
    }

    q := &MaxHeap{}
    heap.Push(q, Point{0, 0, grid[0][0]})
    danger[0][0] = grid[0][0]

    for q.Len() > 0 {
        p := heap.Pop(q).(Point)
        for _, d := range dir {
            x, y := p.x+d[0], p.y+d[1]
            if x >= 0 && x < n && y >= 0 && y < m {
                newDanger := max(p.danger, grid[x][y])
                if newDanger < danger[x][y] || danger[x][y] == 0 {
                    danger[x][y] = newDanger
                    heap.Push(q, Point{x, y, newDanger})
                }
            }
        }
    }

    return danger[n-1][m-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    grid := [][]int{{0, 1, 1}, {1, 0, 1}, {1, 1, 0}}
    result := maximumSafeness(grid)
    println(result)
}
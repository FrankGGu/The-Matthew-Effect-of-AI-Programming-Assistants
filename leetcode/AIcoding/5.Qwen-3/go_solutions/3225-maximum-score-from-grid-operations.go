package main

func maximumScore(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    maxHeap := make([]int, 0)
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            maxHeap = append(maxHeap, grid[i][j])
        }
    }
    sort.Sort(sort.Reverse(sort.IntSlice(maxHeap)))
    res := 0
    for i := 0; i < m*n; i++ {
        if i%2 == 0 {
            res += maxHeap[i]
        } else {
            res -= maxHeap[i]
        }
    }
    return res
}
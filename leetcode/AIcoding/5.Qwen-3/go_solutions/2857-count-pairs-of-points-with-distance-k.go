package main

func countPairs(coords [][]int, k int) int {
    count := 0
    n := len(coords)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            dx := coords[i][0] - coords[j][0]
            dy := coords[i][1] - coords[j][1]
            if dx*dx+dy*dy == k*k {
                count++
            }
        }
    }
    return count
}
package main

func findMissingAndRepeatedValues(n int, m [][]int) []int {
    seen := make(map[int]bool)
    var repeated int
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            num := m[i][j]
            if seen[num] {
                repeated = num
            } else {
                seen[num] = true
            }
        }
    }
    for i := 1; i <= n*n; i++ {
        if !seen[i] {
            return []int{i, repeated}
        }
    }
    return []int{-1, repeated}
}
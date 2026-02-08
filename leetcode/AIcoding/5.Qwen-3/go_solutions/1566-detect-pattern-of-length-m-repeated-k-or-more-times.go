package main

func containsPattern(arr []int, m int, k int) bool {
    n := len(arr)
    for i := 0; i <= n-m; i++ {
        found := true
        for j := 1; j < k; j++ {
            start := i + j*m
            end := start + m
            if end > n {
                found = false
                break
            }
            for p := 0; p < m; p++ {
                if arr[i+p] != arr[start+p] {
                    found = false
                    break
                }
            }
            if !found {
                break
            }
        }
        if found {
            return true
        }
    }
    return false
}
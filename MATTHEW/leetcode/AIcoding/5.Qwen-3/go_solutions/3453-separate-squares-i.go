package main

func distinctSquareSum(n int) int {
    seen := make(map[int]bool)
    count := 0
    for i := 0; i*i <= n; i++ {
        for j := i; j*j <= n; j++ {
            sum := i*i + j*j
            if sum <= n && !seen[sum] {
                seen[sum] = true
                count++
            }
        }
    }
    return count
}
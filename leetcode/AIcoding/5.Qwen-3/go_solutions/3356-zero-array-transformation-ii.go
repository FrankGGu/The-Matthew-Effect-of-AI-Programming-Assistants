package main

func isPossibleToGetTarget(n int, queries []int) bool {
    nums := make([]int, n)
    for _, q := range queries {
        if q >= n {
            continue
        }
        nums[q]++
    }
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            return false
        }
    }
    return true
}
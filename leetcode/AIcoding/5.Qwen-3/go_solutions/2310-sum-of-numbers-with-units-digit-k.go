package main

func minimumSum(n int, k int) int {
    seen := make(map[int]bool)
    res := 0
    count := 0
    for count < n {
        if !seen[n] {
            res += n
            count++
            for i := 1; i <= 9; i++ {
                seen[n+i*10] = true
            }
        }
        n++
    }
    return res
}
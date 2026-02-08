package main

func minTimeToBreakLocks(locks []int, k int) int {
    n := len(locks)
    if n == 0 {
        return 0
    }
    times := make([]int, n)
    for i := 0; i < n; i++ {
        times[i] = locks[i]
    }
    for i := 0; i < k; i++ {
        maxIndex := 0
        for j := 1; j < n; j++ {
            if times[j] > times[maxIndex] {
                maxIndex = j
            }
        }
        times[maxIndex] = times[maxIndex] / 2
    }
    result := 0
    for _, t := range times {
        result += t
    }
    return result
}
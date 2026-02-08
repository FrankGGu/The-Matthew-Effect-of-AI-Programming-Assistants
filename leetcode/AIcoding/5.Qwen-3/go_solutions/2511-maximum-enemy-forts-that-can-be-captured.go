package main

func captureForts(forts []int) int {
    maxCaptured := 0
    n := len(forts)
    for i := 0; i < n; i++ {
        if forts[i] == 1 {
            left := i - 1
            right := i + 1
            count := 0
            for left >= 0 && forts[left] == 0 {
                count++
                left--
            }
            for right < n && forts[right] == 0 {
                count++
                right++
            }
            if count > maxCaptured {
                maxCaptured = count
            }
        }
    }
    return maxCaptured
}
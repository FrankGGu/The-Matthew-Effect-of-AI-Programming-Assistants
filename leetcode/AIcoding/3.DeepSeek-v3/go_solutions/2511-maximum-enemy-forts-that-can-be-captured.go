func captureForts(forts []int) int {
    maxCaptured := 0
    n := len(forts)

    for i := 0; i < n; i++ {
        if forts[i] == 1 {
            left, right := 0, 0
            for j := i - 1; j >= 0; j-- {
                if forts[j] == -1 {
                    break
                }
                if forts[j] == 0 {
                    left++
                } else {
                    left = 0
                    break
                }
            }
            for j := i + 1; j < n; j++ {
                if forts[j] == -1 {
                    break
                }
                if forts[j] == 0 {
                    right++
                } else {
                    right = 0
                    break
                }
            }
            currentMax := max(left, right)
            if currentMax > maxCaptured {
                maxCaptured = currentMax
            }
        }
    }

    return maxCaptured
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
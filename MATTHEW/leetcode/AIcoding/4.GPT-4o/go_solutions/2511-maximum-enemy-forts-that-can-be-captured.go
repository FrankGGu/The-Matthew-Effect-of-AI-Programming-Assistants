func captureForts(forts []int) int {
    maxCapture := 0
    n := len(forts)

    for i := 0; i < n; i++ {
        if forts[i] == 1 {
            left := i - 1
            for left >= 0 && forts[left] == 0 {
                left--
            }
            if left >= 0 && forts[left] == -1 {
                maxCapture = max(maxCapture, i-left-1)
            }
        } else if forts[i] == -1 {
            right := i + 1
            for right < n && forts[right] == 0 {
                right++
            }
            if right < n && forts[right] == 1 {
                maxCapture = max(maxCapture, right-i-1)
            }
        }
    }

    return maxCapture
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
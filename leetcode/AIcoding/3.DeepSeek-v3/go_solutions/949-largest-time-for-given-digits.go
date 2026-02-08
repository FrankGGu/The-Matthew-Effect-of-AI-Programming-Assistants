func largestTimeFromDigits(arr []int) string {
    maxTime := -1
    for i := 0; i < 4; i++ {
        for j := 0; j < 4; j++ {
            if j == i {
                continue
            }
            for k := 0; k < 4; k++ {
                if k == i || k == j {
                    continue
                }
                l := 6 - i - j - k
                hours := 10*arr[i] + arr[j]
                minutes := 10*arr[k] + arr[l]
                if hours < 24 && minutes < 60 {
                    maxTime = max(maxTime, hours*60+minutes)
                }
            }
        }
    }
    if maxTime == -1 {
        return ""
    }
    return fmt.Sprintf("%02d:%02d", maxTime/60, maxTime%60)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
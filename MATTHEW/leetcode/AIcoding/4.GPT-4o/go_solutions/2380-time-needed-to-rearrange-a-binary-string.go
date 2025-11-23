func minTimeToRearrange(s string) int {
    count0, count1 := 0, 0
    for _, ch := range s {
        if ch == '0' {
            count0++
        } else {
            count1++
        }
    }
    return max(count0, count1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
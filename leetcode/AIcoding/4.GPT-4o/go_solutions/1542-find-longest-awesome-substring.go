func longestAwesome(s string) int {
    mask := 0
    maxLength := 0
    seen := map[int]int{0: -1}

    for i := 0; i < len(s); i++ {
        mask ^= 1 << (s[i] - '0')
        if idx, ok := seen[mask]; ok {
            maxLength = max(maxLength, i-idx)
        }
        for j := 0; j < 10; j++ {
            if idx, ok := seen[mask^(1<<j)]; ok {
                maxLength = max(maxLength, i-idx)
            }
        }
        if _, ok := seen[mask]; !ok {
            seen[mask] = i
        }
    }
    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
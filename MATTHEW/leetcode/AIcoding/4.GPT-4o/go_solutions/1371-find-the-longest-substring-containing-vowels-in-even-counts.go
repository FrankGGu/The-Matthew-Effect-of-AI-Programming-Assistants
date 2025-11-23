func findTheLongestSubstring(s string) int {
    m := make(map[int]int)
    m[0] = -1
    maxLength := 0
    mask := 0

    for i, char := range s {
        switch char {
        case 'a':
            mask ^= 1 << 0
        case 'e':
            mask ^= 1 << 1
        case 'i':
            mask ^= 1 << 2
        case 'o':
            mask ^= 1 << 3
        case 'u':
            mask ^= 1 << 4
        }

        if prevIndex, found := m[mask]; found {
            maxLength = max(maxLength, i-prevIndex)
        } else {
            m[mask] = i
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
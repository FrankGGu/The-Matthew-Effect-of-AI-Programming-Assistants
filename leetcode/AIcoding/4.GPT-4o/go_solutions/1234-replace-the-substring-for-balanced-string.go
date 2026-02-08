func balancedString(s string) int {
    count := map[rune]int{'Q': 0, 'W': 0, 'E': 0, 'R': 0}
    for _, ch := range s {
        count[ch]++
    }
    n := len(s)
    target := n / 4
    if count['Q'] == target && count['W'] == target && count['E'] == target && count['R'] == target {
        return 0
    }

    left, minLength := 0, n
    for right, ch := range s {
        count[ch]--
        for left <= right && count['Q'] <= target && count['W'] <= target && count['E'] <= target && count['R'] <= target {
            minLength = min(minLength, right-left+1)
            count[rune(s[left])]++
            left++
        }
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
func wordCount(startWords []string, targetWords []string) int {
    seen := make(map[int]bool)
    for _, word := range startWords {
        mask := 0
        for _, ch := range word {
            mask |= 1 << (ch - 'a')
        }
        seen[mask] = true
    }

    res := 0
    for _, word := range targetWords {
        mask := 0
        for _, ch := range word {
            mask |= 1 << (ch - 'a')
        }
        for _, ch := range word {
            if seen[mask ^ (1 << (ch - 'a'))] {
                res++
                break
            }
        }
    }
    return res
}
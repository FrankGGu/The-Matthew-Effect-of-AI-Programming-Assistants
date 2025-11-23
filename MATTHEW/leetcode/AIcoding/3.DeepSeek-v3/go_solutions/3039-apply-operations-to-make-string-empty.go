func makeStringEmpty(s string) int {
    lastOccur := make(map[byte]int)
    for i := 0; i < len(s); i++ {
        lastOccur[s[i]] = i
    }

    res := 0
    end := -1
    for i := 0; i < len(s); i++ {
        if i > end {
            res++
        }
        if lastOccur[s[i]] > end {
            end = lastOccur[s[i]]
        }
    }
    return res
}
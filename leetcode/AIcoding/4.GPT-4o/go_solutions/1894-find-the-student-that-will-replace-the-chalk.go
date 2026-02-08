func chalkReplacer(chalk []int, k int) int {
    totalChalk := 0
    for _, c := range chalk {
        totalChalk += c
    }
    k %= totalChalk
    for i, c := range chalk {
        if k < c {
            return i
        }
        k -= c
    }
    return -1
}
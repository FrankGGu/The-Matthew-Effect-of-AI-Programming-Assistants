func chalkReplacer(chalk []int, k int) int {
    total := 0
    for _, num := range chalk {
        total += num
    }
    k %= total
    for i := 0; i < len(chalk); i++ {
        if k < chalk[i] {
            return i
        }
        k -= chalk[i]
    }
    return -1
}
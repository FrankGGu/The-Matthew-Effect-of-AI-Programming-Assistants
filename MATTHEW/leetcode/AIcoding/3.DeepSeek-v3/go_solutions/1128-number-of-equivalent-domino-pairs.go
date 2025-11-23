func numEquivDominoPairs(dominoes [][]int) int {
    count := make(map[int]int)
    pairs := 0
    for _, d := range dominoes {
        a, b := d[0], d[1]
        if a > b {
            a, b = b, a
        }
        key := a*10 + b
        pairs += count[key]
        count[key]++
    }
    return pairs
}
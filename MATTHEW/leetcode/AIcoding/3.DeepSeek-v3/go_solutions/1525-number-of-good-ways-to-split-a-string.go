func numSplits(s string) int {
    left := make(map[rune]int)
    right := make(map[rune]int)

    for _, c := range s {
        right[c]++
    }

    res := 0
    for _, c := range s {
        left[c]++
        right[c]--
        if right[c] == 0 {
            delete(right, c)
        }
        if len(left) == len(right) {
            res++
        }
    }
    return res
}
func removeAlmostEqualCharacters(word string) int {
    n := len(word)
    res := 0
    for i := 1; i < n; i++ {
        if abs(int(word[i]) - int(word[i-1])) <= 1 {
            res++
            i++
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
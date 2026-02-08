func maxGroups(grades []int) int {
    n := len(grades)
    k := 0
    for i := 1; n >= (i * (i + 1)) / 2; i++ {
        k = i
    }
    return k
}
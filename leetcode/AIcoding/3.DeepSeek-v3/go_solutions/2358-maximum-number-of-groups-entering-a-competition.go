func maximumGroups(grades []int) int {
    n := len(grades)
    k := 0
    for (k+1)*(k+2)/2 <= n {
        k++
    }
    return k
}
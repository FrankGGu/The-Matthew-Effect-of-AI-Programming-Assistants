func checkIfCanBreak(s1 string, s2 string) bool {
    r1 := []rune(s1)
    r2 := []rune(s2)
    sort.Slice(r1, func(i, j int) bool { return r1[i] < r1[j] })
    sort.Slice(r2, func(i, j int) bool { return r2[i] < r2[j] })

    n := len(r1)
    check1, check2 := true, true
    for i := 0; i < n; i++ {
        if r1[i] < r2[i] {
            check1 = false
        }
        if r2[i] < r1[i] {
            check2 = false
        }
        if !check1 && !check2 {
            return false
        }
    }
    return check1 || check2
}
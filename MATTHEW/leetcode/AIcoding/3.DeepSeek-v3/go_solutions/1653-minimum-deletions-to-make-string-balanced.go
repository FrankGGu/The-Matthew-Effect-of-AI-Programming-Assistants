func minimumDeletions(s string) int {
    aCount := 0
    for _, c := range s {
        if c == 'a' {
            aCount++
        }
    }

    res := aCount
    bCount := 0
    for _, c := range s {
        if c == 'a' {
            aCount--
        } else {
            bCount++
        }
        if res > aCount + bCount {
            res = aCount + bCount
        }
    }
    return res
}
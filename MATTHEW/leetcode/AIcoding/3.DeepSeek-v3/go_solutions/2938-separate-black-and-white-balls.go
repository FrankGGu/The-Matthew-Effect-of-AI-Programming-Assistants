func minimumSteps(s string) int64 {
    var res, count int64
    for i := 0; i < len(s); i++ {
        if s[i] == '1' {
            count++
        } else {
            res += count
        }
    }
    return res
}
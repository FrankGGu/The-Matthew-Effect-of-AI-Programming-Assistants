func countSubstrings(s string) int64 {
    var res, count int64
    for _, c := range s {
        if c == '1' {
            count++
            res += count
        } else {
            count = 0
        }
    }
    return res
}
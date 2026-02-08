func numSub(s string) int {
    count, result := 0, 0
    mod := 1000000007

    for _, ch := range s {
        if ch == '1' {
            count++
            result = (result + count) % mod
        } else {
            count = 0
        }
    }

    return result
}
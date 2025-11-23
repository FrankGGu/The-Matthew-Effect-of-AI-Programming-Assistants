func countHomogenous(s string) int {
    mod := 1000000007
    count, total := 1, 1

    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            count++
        } else {
            count = 1
        }
        total = (total + count) % mod
    }

    return total
}
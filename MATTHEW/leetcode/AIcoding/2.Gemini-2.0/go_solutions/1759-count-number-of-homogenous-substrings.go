func countHomogenous(s string) int {
    ans := 0
    mod := 1000000007
    count := 0
    for i := 0; i < len(s); i++ {
        if i > 0 && s[i] == s[i-1] {
            count++
        } else {
            count = 1
        }
        ans = (ans + count) % mod
    }
    return ans
}
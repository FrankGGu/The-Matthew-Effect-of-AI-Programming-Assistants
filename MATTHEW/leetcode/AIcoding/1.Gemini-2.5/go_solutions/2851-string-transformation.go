func minOperations(s string, t string) int {
    ans := 0
    for i := 0; i < len(s); i++ {
        if s[i] != t[i] {
            ans++
        }
    }
    return ans
}
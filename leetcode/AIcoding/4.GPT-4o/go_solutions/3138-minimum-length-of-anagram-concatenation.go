func minLength(s string) int {
    count := make([]int, 26)
    for _, ch := range s {
        count[ch-'a']++
    }
    ans := 0
    for _, c := range count {
        if c > 0 {
            ans += c % 2
        }
    }
    return ans
}
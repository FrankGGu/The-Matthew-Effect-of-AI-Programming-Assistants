func countSubstrings(s string) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        num := 0
        for j := i; j < n; j++ {
            num = num * 10 + int(s[j] - '0')
            if num % 10 == 0 || num % (num % 10) == 0 {
                count++
            }
        }
    }
    return count
}
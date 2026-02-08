func longestSubsequence(s string, k int) int {
    n := len(s)
    count := 0
    num := 0

    for i := 0; i < n; i++ {
        if s[i] == '0' {
            count++
        } else if num < k {
            num = num<<1 | 1
            count++
        } else {
            break
        }

        if num > k {
            break
        }
    }

    return count
}
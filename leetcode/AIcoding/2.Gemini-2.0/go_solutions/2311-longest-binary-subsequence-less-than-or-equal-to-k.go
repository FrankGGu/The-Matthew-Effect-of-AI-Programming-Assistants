func longestSubsequence(s string, k int) int {
    count := 0
    val := 0
    power := 1
    for i := len(s) - 1; i >= 0; i-- {
        if s[i] == '0' {
            count++
        } else {
            if power <= k {
                val += power
                if val <= k {
                    count++
                } else {
                    val -= power
                }
            }
            power *= 2
        }
    }
    return count
}
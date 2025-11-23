func maximumSubsequenceCount(text string, pattern string) int64 {
    var count1, count2, res int64
    a, b := pattern[0], pattern[1]
    for i := 0; i < len(text); i++ {
        if text[i] == b {
            res += count1
            count2++
        }
        if text[i] == a {
            count1++
        }
    }
    if a == b {
        return count1 * (count1 + 1) / 2
    }
    if res + count1 > res + count2 {
        return res + count1
    }
    return res + count2
}
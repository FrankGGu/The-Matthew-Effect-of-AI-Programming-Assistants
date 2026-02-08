func minPartitions(n string) int {
    ans := 0
    for _, r := range n {
        digit := int(r - '0')
        if digit > ans {
            ans = digit
        }
    }
    return ans
}
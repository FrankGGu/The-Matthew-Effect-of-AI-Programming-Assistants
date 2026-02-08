func minimumPartition(s string, k int) int {
    res := 0
    current := 0
    for _, ch := range s {
        digit := int(ch - '0')
        if digit > k {
            return -1
        }
        if current * 10 + digit > k {
            res++
            current = digit
        } else {
            current = current * 10 + digit
        }
    }
    if current > 0 {
        res++
    }
    return res
}
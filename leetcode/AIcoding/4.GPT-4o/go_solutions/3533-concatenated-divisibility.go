func concatenatedBinary(n int) int {
    mod := 1_000_000_007
    result := 0
    length := 0

    for i := 1; i <= n; i++ {
        if i&(i-1) == 0 {
            length++
        }
        result = ((result << length) % mod + i) % mod
    }

    return result
}
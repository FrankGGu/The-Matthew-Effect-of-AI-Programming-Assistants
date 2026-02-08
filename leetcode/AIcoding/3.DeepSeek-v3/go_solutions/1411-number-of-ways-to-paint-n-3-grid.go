func numOfWays(n int) int {
    mod := int(1e9 + 7)
    a121, a123 := 6, 6
    for i := 1; i < n; i++ {
        newA121 := (3 * a121 + 2 * a123) % mod
        newA123 := (2 * a121 + 2 * a123) % mod
        a121, a123 = newA121, newA123
    }
    return (a121 + a123) % mod
}
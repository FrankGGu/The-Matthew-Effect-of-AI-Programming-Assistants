func superPow(a int, b []int) int {
    const mod = 1337
    if len(b) == 0 {
        return 1
    }
    last := b[len(b)-1]
    b = b[:len(b)-1]
    part1 := pow(a, last)
    part2 := pow(superPow(a, b), 10)
    return (part1 * part2) % mod
}

func pow(a, b int) int {
    const mod = 1337
    res := 1
    a %= mod
    for i := 0; i < b; i++ {
        res = (res * a) % mod
    }
    return res
}
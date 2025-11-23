func commonFactors(a int, b int) int {
    gcd := func(x, y int) int {
        for y != 0 {
            x, y = y, x%y
        }
        return x
    }

    count := 0
    g := gcd(a, b)
    for i := 1; i*i <= g; i++ {
        if g%i == 0 {
            count++
            if i != g/i {
                count++
            }
        }
    }
    return count
}
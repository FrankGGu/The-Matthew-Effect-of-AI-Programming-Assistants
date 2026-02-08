func minimizeXor(num1 int, num2 int) int {
    countBits := func(n int) int {
        count := 0
        for n > 0 {
            count += n & 1
            n >>= 1
        }
        return count
    }

    c1 := countBits(num1)
    c2 := countBits(num2)

    if c1 == c2 {
        return num1
    }

    res := num1
    if c1 > c2 {
        diff := c1 - c2
        for i := 0; i < 32 && diff > 0; i++ {
            if res & (1 << i) != 0 {
                res ^= (1 << i)
                diff--
            }
        }
    } else {
        diff := c2 - c1
        for i := 0; i < 32 && diff > 0; i++ {
            if res & (1 << i) == 0 {
                res ^= (1 << i)
                diff--
            }
        }
    }

    return res
}
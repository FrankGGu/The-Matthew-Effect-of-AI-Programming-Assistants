func makeIntegerBeautiful(n int64, target int) int64 {
    sumDigits := func(x int64) int {
        sum := 0
        for x > 0 {
            sum += int(x % 10)
            x /= 10
        }
        return sum
    }

    var add int64 = 0
    power := int64(1)
    for sumDigits(n+add) > target {
        digit := (n + add) / power % 10
        delta := (10 - digit) * power
        add += delta
        power *= 10
    }
    return add
}
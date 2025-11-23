func makeIntegerBeautiful(n int64, target int) int64 {
    sumDigits := func(x int64) int {
        sum := 0
        for x > 0 {
            sum += int(x % 10)
            x /= 10
        }
        return sum
    }

    var m int64 = 1
    var res int64 = 0
    for sumDigits(n+res) > target {
        m *= 10
        diff := m - (n + res) % m
        res += diff
    }
    return res
}
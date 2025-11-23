func reorderedPowerOf2(n int) bool {
    countDigits := func(num int) [10]int {
        count := [10]int{}
        for num > 0 {
            digit := num % 10
            count[digit]++
            num /= 10
        }
        return count
    }

    target := countDigits(n)
    for i := 0; i < 31; i++ {
        power := 1 << i
        current := countDigits(power)
        if current == target {
            return true
        }
    }
    return false
}
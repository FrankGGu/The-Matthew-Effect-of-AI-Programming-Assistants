func selfDividingNumbers(left int, right int) []int {
    var result []int

    for i := left; i <= right; i++ {
        if isSelfDividing(i) {
            result = append(result, i)
        }
    }

    return result
}

func isSelfDividing(n int) bool {
    temp := n
    for temp > 0 {
        digit := temp % 10
        if digit == 0 || n % digit != 0 {
            return false
        }
        temp /= 10
    }
    return true
}
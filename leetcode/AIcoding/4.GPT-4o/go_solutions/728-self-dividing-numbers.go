func selfDividingNumbers(left int, right int) []int {
    result := []int{}
    for num := left; num <= right; num++ {
        if isSelfDividing(num) {
            result = append(result, num)
        }
    }
    return result
}

func isSelfDividing(num int) bool {
    original := num
    for num > 0 {
        digit := num % 10
        if digit == 0 || original%digit != 0 {
            return false
        }
        num /= 10
    }
    return true
}
func selfDividingNumbers(left int, right int) []int {
    var res []int
    for num := left; num <= right; num++ {
        if isSelfDividing(num) {
            res = append(res, num)
        }
    }
    return res
}

func isSelfDividing(num int) bool {
    original := num
    for num > 0 {
        digit := num % 10
        if digit == 0 || original % digit != 0 {
            return false
        }
        num /= 10
    }
    return true
}
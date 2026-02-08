func punishmentNumber(n int) int {
    sum := 0
    for i := 1; i <= n; i++ {
        square := i * i
        if canSplit(square, i) {
            sum += square
        }
    }
    return sum
}

func canSplit(num, target int) bool {
    if num == target {
        return true
    }
    if num < target {
        return false
    }
    divisor := 10
    for divisor <= num {
        quotient := num / divisor
        remainder := num % divisor
        if remainder > target {
            divisor *= 10
            continue
        }
        if canSplit(quotient, target-remainder) {
            return true
        }
        divisor *= 10
    }
    return false
}
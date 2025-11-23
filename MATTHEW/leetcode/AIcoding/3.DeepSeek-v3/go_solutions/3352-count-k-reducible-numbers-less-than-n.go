func countKReducibleNumbers(n int, k int) int {
    count := 0
    for num := 1; num < n; num++ {
        if isKReducible(num, k) {
            count++
        }
    }
    return count
}

func isKReducible(num int, k int) bool {
    steps := 0
    for num > 0 {
        num = num - digitSum(num)
        steps++
        if steps > k {
            return false
        }
    }
    return steps == k
}

func digitSum(num int) int {
    sum := 0
    for num > 0 {
        sum += num % 10
        num /= 10
    }
    return sum
}
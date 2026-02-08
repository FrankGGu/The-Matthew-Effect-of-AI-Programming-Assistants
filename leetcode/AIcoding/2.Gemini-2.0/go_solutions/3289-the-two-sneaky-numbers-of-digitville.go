func sumOfDigits(n int) int {
    sum := 0
    for n > 0 {
        sum += n % 10
        n /= 10
    }
    return sum
}

func findTheNumbers(n int) []int {
    a := (n - sumOfDigits(n))
    return []int{a, n - a}
}
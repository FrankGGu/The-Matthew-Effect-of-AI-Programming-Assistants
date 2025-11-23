func minimumSum(num int) int {
    digits := make([]int, 4)
    for i := 0; i < 4; i++ {
        digits[i] = num % 10
        num /= 10
    }
    sort.Ints(digits)
    return (digits[0]+digits[1])*10 + digits[2] + digits[3]
}
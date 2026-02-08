func splitNum(num int) int {
    digits := []int{}
    for num > 0 {
        digits = append(digits, num%10)
        num /= 10
    }
    sort.Ints(digits)

    num1, num2 := 0, 0
    for i, d := range digits {
        if i%2 == 0 {
            num1 = num1*10 + d
        } else {
            num2 = num2*10 + d
        }
    }
    return num1 + num2
}
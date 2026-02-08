package main

func splitNum(num int) int {
    digits := make([]int, 0)
    for num > 0 {
        digits = append(digits, num%10)
        num /= 10
    }
    sort.Ints(digits)
    a, b := 0, 0
    for i := 0; i < len(digits); i++ {
        if i%2 == 0 {
            a = a*10 + digits[i]
        } else {
            b = b*10 + digits[i]
        }
    }
    return a + b
}
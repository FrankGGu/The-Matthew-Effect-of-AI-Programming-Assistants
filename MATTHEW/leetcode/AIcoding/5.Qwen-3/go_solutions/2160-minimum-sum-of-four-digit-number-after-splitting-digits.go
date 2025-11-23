package main

func minimumSum(n int) int {
    digits := make([]int, 0)
    for n > 0 {
        digits = append(digits, n%10)
        n /= 10
    }
    sort.Ints(digits)
    return digits[0]*10 + digits[1]*10 + digits[2] + digits[3]
}
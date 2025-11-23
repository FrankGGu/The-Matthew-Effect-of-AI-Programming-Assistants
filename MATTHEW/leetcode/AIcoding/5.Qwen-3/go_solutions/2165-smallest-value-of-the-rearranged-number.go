package main

func smallestNumber(n int) int {
    if n == 0 {
        return 0
    }
    digits := []int{}
    for n > 0 {
        digits = append(digits, n%10)
        n /= 10
    }
    if digits[0] == 0 {
        for i := 0; i < len(digits); i++ {
            if digits[i] != 0 {
                digits[0], digits[i] = digits[i], digits[0]
                break
            }
        }
    }
    for i := 0; i < len(digits)-1; i++ {
        for j := i + 1; j < len(digits); j++ {
            if digits[i] > digits[j] {
                digits[i], digits[j] = digits[j], digits[i]
            }
        }
    }
    result := 0
    for _, d := range digits {
        result = result*10 + d
    }
    return result
}
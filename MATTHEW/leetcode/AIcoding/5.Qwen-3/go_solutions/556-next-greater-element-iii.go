package main

func nextGreaterElement(n int) int {
    digits := []int{}
    for n > 0 {
        digits = append(digits, n%10)
        n /= 10
    }

    for i := 0; i < len(digits)-1; i++ {
        if digits[i] > digits[i+1] {
            for j := i + 1; j < len(digits); j++ {
                if digits[j] > digits[i] {
                    digits[i], digits[j] = digits[j], digits[i]
                    break
                }
            }
            break
        }
    }

    for i, j := 0, len(digits)-1; i < j; i, j = i+1, j-1 {
        digits[i], digits[j] = digits[j], digits[i]
    }

    result := 0
    for _, d := range digits {
        result = result*10 + d
        if result > 2147483647 {
            return -1
        }
    }

    return result
}
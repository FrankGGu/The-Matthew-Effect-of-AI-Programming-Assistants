package main

import "strconv"

func smallestNumber(num int) int {
    if num == 0 {
        return 0
    }

    digits := make([]int, 0)
    absNum := num
    if num < 0 {
        absNum = -num
    }

    for absNum > 0 {
        digits = append(digits, absNum%10)
        absNum /= 10
    }

    if num > 0 {
        sort.Ints(digits)
        if digits[0] == 0 {
            for i := 1; i < len(digits); i++ {
                if digits[i] > 0 {
                    digits[0], digits[i] = digits[i], digits[0]
                    break
                }
            }
        }
    } else {
        sort.Sort(sort.Reverse(sort.IntSlice(digits)))
    }

    result := 0
    for _, digit := range digits {
        result = result*10 + digit
    }

    if num < 0 {
        result = -result
    }

    return result
}
package main

func maxProduct(digits string) int {
    max1 := -1
    max2 := -1
    for _, c := range digits {
        digit := int(c - '0')
        if digit > max1 {
            max2 = max1
            max1 = digit
        } else if digit > max2 {
            max2 = digit
        }
    }
    return max1 * max2
}
package main

func convertToBase7(num int) string {
    if num == 0 {
        return "0"
    }
    var digits []rune
    negative := num < 0
    if negative {
        num = -num
    }
    for num > 0 {
        digits = append(digits, rune('0'+num%7))
        num /= 7
    }
    if negative {
        digits = append(digits, '-')
    }
    for i, j := 0, len(digits)-1; i < j; i, j = i+1, j-1 {
        digits[i], digits[j] = digits[j], digits[i]
    }
    return string(digits)
}
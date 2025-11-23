package main

func intToRoman(num int) string {
    values := []int{1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1}
    symbols := []string{"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"}
    roman := ""
    for i := 0; num > 0; i++ {
        for num >= values[i] {
            roman += symbols[i]
            num -= values[i]
        }
    }
    return roman
}
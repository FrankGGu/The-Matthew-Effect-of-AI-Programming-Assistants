func maxProduct(digits int) int {
    max1, max2 := 0, 0
    for digits > 0 {
        digit := digits % 10
        if digit > max1 {
            max2 = max1
            max1 = digit
        } else if digit > max2 {
            max2 = digit
        }
        digits /= 10
    }
    return (max1 - 1) * (max2 - 1)
}
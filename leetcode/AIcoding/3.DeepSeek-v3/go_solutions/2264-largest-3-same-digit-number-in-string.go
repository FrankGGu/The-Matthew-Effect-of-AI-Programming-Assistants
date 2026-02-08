func largestGoodInteger(num string) string {
    maxDigit := -1
    for i := 0; i < len(num)-2; i++ {
        if num[i] == num[i+1] && num[i] == num[i+2] {
            digit := int(num[i] - '0')
            if digit > maxDigit {
                maxDigit = digit
            }
        }
    }
    if maxDigit == -1 {
        return ""
    }
    return strings.Repeat(string(byte(maxDigit+'0')), 3)
}
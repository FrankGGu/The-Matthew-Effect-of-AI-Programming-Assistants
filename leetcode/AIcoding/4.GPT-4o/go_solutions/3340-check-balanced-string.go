func checkBalancedString(s string) bool {
    count := 0
    for _, char := range s {
        if char == '(' {
            count++
        } else if char == ')' {
            count--
        }
        if count < 0 {
            return false
        }
    }
    return count == 0
}
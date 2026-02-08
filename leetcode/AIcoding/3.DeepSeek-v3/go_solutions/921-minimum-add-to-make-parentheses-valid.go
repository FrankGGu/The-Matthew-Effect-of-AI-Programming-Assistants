func minAddToMakeValid(s string) int {
    left, right := 0, 0
    for _, c := range s {
        if c == '(' {
            left++
        } else {
            if left > 0 {
                left--
            } else {
                right++
            }
        }
    }
    return left + right
}
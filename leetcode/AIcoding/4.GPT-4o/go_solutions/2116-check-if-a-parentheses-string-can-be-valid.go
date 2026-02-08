func checkValidString(s string) bool {
    left, star := 0, 0
    for _, char := range s {
        if char == '(' {
            left++
        } else if char == ')' {
            left--
        } else {
            star++
        }
        if left < 0 {
            if star > 0 {
                left++
                star--
            } else {
                return false
            }
        }
    }
    return left <= star
}
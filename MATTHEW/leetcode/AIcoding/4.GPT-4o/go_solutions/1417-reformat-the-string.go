func reformat(s string) string {
    letters := []rune{}
    digits := []rune{}

    for _, ch := range s {
        if ch >= '0' && ch <= '9' {
            digits = append(digits, ch)
        } else {
            letters = append(letters, ch)
        }
    }

    if abs(len(letters)-len(digits)) > 1 {
        return ""
    }

    result := []rune{}
    i, j := 0, 0
    if len(letters) > len(digits) {
        for i < len(letters) || j < len(digits) {
            if i < len(letters) {
                result = append(result, letters[i])
                i++
            }
            if j < len(digits) {
                result = append(result, digits[j])
                j++
            }
        }
    } else {
        for i < len(digits) || j < len(letters) {
            if i < len(digits) {
                result = append(result, digits[i])
                i++
            }
            if j < len(letters) {
                result = append(result, letters[j])
                j++
            }
        }
    }

    return string(result)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
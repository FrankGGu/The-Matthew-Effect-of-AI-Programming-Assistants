package main

func reformat(s string) string {
    var letters []rune
    var digits []rune

    for _, c := range s {
        if c >= 'a' && c <= 'z' {
            letters = append(letters, c)
        } else {
            digits = append(digits, c)
        }
    }

    if abs(len(letters)-len(digits)) > 1 {
        return ""
    }

    var result []rune
    i := 0
    j := 0

    if len(letters) > len(digits) {
        for i < len(letters) || j < len(digits) {
            result = append(result, letters[i])
            i++
            if j < len(digits) {
                result = append(result, digits[j])
                j++
            }
        }
    } else {
        for i < len(letters) || j < len(digits) {
            result = append(result, digits[j])
            j++
            if i < len(letters) {
                result = append(result, letters[i])
                i++
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
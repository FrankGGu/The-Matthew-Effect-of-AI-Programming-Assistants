func isPalindrome(s string) bool {
    l, r := 0, len(s)-1
    for l < r {
        for l < r && !isAlphanumeric(s[l]) {
            l++
        }
        for l < r && !isAlphanumeric(s[r]) {
            r--
        }
        if toLower(s[l]) != toLower(s[r]) {
            return false
        }
        l++
        r--
    }
    return true
}

func isAlphanumeric(char byte) bool {
    return (char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z') || (char >= '0' && char <= '9')
}

func toLower(char byte) byte {
    if char >= 'A' && char <= 'Z' {
        return char + 32
    }
    return char
}
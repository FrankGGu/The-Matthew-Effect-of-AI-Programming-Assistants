func replaceDigits(s string) string {
    result := []byte(s)
    for i := 1; i < len(result); i += 2 {
        // s[i-1] is the preceding character (a letter)
        // s[i] is the digit character
        // Convert the digit character to its integer value
        digitValue := result[i] - '0'

        // Shift the preceding character by the digit value
        // The problem guarantees that this shift will not exceed 'z'
        result[i] = result[i-1] + digitValue
    }
    return string(result)
}
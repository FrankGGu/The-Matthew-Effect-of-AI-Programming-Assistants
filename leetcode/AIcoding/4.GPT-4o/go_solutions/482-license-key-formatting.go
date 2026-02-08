func licenseKeyFormatting(S string, K int) string {
    var sb strings.Builder
    count := 0

    for i := len(S) - 1; i >= 0; i-- {
        if S[i] != '-' {
            if count > 0 && count%K == 0 {
                sb.WriteByte('-')
            }
            sb.WriteByte(bytes.ToUpper([]byte{S[i]})[0])
            count++
        }
    }

    result := sb.String()
    // Reverse the result
    runes := []rune(result)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }

    return string(runes)
}
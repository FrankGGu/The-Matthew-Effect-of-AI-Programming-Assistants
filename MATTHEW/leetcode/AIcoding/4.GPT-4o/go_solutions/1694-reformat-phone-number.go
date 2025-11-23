func reformatNumber(number string) string {
    number = strings.ReplaceAll(number, " ", "")
    number = strings.ReplaceAll(number, "-", "")

    n := len(number)
    var result strings.Builder

    for i := 0; i < n; i += 3 {
        if n-i == 4 {
            result.WriteString(number[i : i+2])
            result.WriteByte('-')
            result.WriteString(number[i+2 : i+4])
            break
        } else if n-i < 4 {
            result.WriteString(number[i:])
            break
        } else {
            result.WriteString(number[i : i+3])
            result.WriteByte('-')
        }
    }

    return result.String()
}
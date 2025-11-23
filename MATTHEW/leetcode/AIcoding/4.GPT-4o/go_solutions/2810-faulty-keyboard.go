func finalString(s string) string {
    var result []byte
    for i := 0; i < len(s); i++ {
        if s[i] == 'i' {
            if len(result) > 0 {
                result = result[:len(result)-1]
            }
        } else {
            result = append(result, s[i])
        }
    }
    return string(result)
}
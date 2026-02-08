func finalString(s string) string {
    var result []rune
    for _, ch := range s {
        if ch == 'i' {
            if len(result) > 0 {
                result = result[:len(result)-1]
            }
        } else {
            result = append(result, ch)
        }
    }
    return string(result)
}
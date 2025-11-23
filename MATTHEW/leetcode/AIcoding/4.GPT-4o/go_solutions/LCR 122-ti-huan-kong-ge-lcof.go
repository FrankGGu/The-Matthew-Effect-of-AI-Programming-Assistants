func encrypt(path string) string {
    result := ""
    for i := 0; i < len(path); i++ {
        if path[i] == 'X' {
            result += "X"
        } else {
            result += string(path[i])
        }
    }
    return result
}
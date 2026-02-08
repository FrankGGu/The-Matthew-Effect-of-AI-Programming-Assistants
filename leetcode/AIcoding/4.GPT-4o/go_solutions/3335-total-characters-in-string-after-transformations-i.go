func transformedStringLength(s string, operations [][]string) int {
    for _, op := range operations {
        if op[0] == "1" {
            s = op[1] + s
        } else if op[0] == "2" {
            s = s + op[1]
        } else if op[0] == "3" {
            s = s[1:]
        } else if op[0] == "4" {
            s = s[:len(s)-1]
        }
    }
    return len(s)
}
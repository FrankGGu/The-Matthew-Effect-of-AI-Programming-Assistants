func addSpaces(s string, spaces []int) string {
    result := make([]byte, len(s) + len(spaces))
    j, k := 0, 0
    for i := 0; i < len(result); i++ {
        if k < len(spaces) && i == spaces[k] {
            result[i] = ' '
            k++
        } else {
            result[i] = s[j]
            j++
        }
    }
    return string(result)
}
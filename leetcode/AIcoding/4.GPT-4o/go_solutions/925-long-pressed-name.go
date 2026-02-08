func isLongPressedName(name string, typed string) bool {
    i, j := 0, 0
    for i < len(name) && j < len(typed) {
        if name[i] == typed[j] {
            i++
            j++
        } else if j > 0 && typed[j] == typed[j-1] {
            j++
        } else {
            return false
        }
    }
    for j < len(typed) {
        if typed[j] != typed[j-1] {
            return false
        }
        j++
    }
    return i == len(name)
}
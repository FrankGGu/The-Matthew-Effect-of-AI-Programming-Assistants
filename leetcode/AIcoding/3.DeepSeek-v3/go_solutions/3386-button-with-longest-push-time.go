func longestPressedName(name string, typed string) bool {
    i, j := 0, 0
    n, m := len(name), len(typed)

    for j < m {
        if i < n && name[i] == typed[j] {
            i++
            j++
        } else if j > 0 && typed[j] == typed[j-1] {
            j++
        } else {
            return false
        }
    }

    return i == n
}
func findOriginalString(typed string) string {
    original := []byte{}
    i, j := 0, 0
    n := len(typed)

    for j < n {
        if i < len(original) && original[i] == typed[j] {
            i++
            j++
        } else {
            original = append(original, typed[j])
            j++
        }
    }

    return string(original)
}
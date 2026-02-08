func findSequence(strings []string) []string {
    n := len(strings)
    if n == 0 {
        return []string{}
    }

    result := make([]string, 0)
    for i := 0; i < n; i++ {
        if len(result) == 0 || result[len(result)-1] != strings[i] {
            result = append(result, strings[i])
        }
    }

    return result
}
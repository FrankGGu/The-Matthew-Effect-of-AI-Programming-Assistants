func removeSubfolders(folder []string) []string {
    sort.Strings(folder)
    result := []string{}

    for i := 0; i < len(folder); i++ {
        if len(result) == 0 || !strings.HasPrefix(folder[i], result[len(result)-1]+"/") {
            result = append(result, folder[i])
        }
    }

    return result
}
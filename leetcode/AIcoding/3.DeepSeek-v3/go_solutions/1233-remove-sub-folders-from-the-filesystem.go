func removeSubfolders(folder []string) []string {
    sort.Strings(folder)
    res := []string{folder[0]}
    for i := 1; i < len(folder); i++ {
        last := res[len(res)-1]
        if !strings.HasPrefix(folder[i], last + "/") {
            res = append(res, folder[i])
        }
    }
    return res
}
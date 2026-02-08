package main

func removeSubfolders(folder []string) []string {
    sort.Strings(folder)
    result := []string{folder[0]}
    for i := 1; i < len(folder); i++ {
        if !strings.HasPrefix(folder[i], result[len(result)-1]+"/") {
            result = append(result, folder[i])
        }
    }
    return result
}
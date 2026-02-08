func getFolderNames(names []string) []string {
    seen := make(map[string]int)
    result := make([]string, len(names))

    for i, name := range names {
        if _, ok := seen[name]; !ok {
            seen[name] = 1
            result[i] = name
        } else {
            k := seen[name]
            newName := name + "(" + string(rune(k+'0')) + ")"
            for {
                if _, ok := seen[newName]; !ok {
                    break
                }
                k++
                newName = name + "(" + string(rune(k+'0')) + ")"
            }
            seen[newName] = 1
            seen[name] = k + 1
            result[i] = newName
        }
    }

    return result
}
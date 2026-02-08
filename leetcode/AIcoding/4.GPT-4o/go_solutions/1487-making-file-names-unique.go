func getFolderNames(names []string) []string {
    nameCount := make(map[string]int)
    result := make([]string, len(names))

    for i, name := range names {
        if _, exists := nameCount[name]; !exists {
            result[i] = name
            nameCount[name] = 1
        } else {
            for j := nameCount[name]; ; j++ {
                newName := fmt.Sprintf("%s(%d)", name, j)
                if _, exists := nameCount[newName]; !exists {
                    result[i] = newName
                    nameCount[newName] = 1
                    nameCount[name] = j + 1
                    break
                }
            }
        }
    }

    return result
}
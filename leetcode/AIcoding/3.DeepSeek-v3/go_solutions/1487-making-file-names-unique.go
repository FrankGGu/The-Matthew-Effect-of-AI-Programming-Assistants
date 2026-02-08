func getFolderNames(names []string) []string {
    nameMap := make(map[string]int)
    result := make([]string, len(names))

    for i, name := range names {
        if count, exists := nameMap[name]; !exists {
            result[i] = name
            nameMap[name] = 1
        } else {
            newName := fmt.Sprintf("%s(%d)", name, count)
            for nameMap[newName] > 0 {
                count++
                newName = fmt.Sprintf("%s(%d)", name, count)
            }
            result[i] = newName
            nameMap[name] = count + 1
            nameMap[newName] = 1
        }
    }

    return result
}
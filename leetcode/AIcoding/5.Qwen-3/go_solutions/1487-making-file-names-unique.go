package main

func getFolderNames(fileNames []string) []string {
    nameMap := make(map[string]int)
    result := make([]string, len(fileNames))

    for i, name := range fileNames {
        if count, ok := nameMap[name]; ok {
            result[i] = name + "." + strconv.Itoa(count)
            nameMap[name]++
            nameMap[result[i]] = 1
        } else {
            result[i] = name
            nameMap[name] = 1
        }
    }

    return result
}
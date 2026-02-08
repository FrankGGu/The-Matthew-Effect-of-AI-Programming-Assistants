package main

func findDuplicate(paths []string) [][]string {
    fileMap := make(map[string][]string)
    for _, path := range paths {
        parts := strings.Split(path, " ")
        dir := parts[0]
        for i := 1; i < len(parts); i++ {
            fileContent := parts[i]
            start := strings.Index(fileContent, "(")
            end := strings.LastIndex(fileContent, ")")
            if start == -1 || end == -1 || start >= end {
                continue
            }
            fileName := fileContent[:start]
            content := fileContent[start+1:end]
            filePath := dir + "/" + fileName
            fileMap[content] = append(fileMap[content], filePath)
        }
    }
    result := [][]string{}
    for _, files := range fileMap {
        if len(files) > 1 {
            result = append(result, files)
        }
    }
    return result
}
func findDuplicate(paths []string) [][]string {
    fileMap := make(map[string][]string)
    for _, path := range paths {
        parts := strings.Split(path, " ")
        root := parts[0]
        for _, file := range parts[1:] {
            idx := strings.Index(file, "(")
            name := file[:idx]
            content := file[idx:]
            fileMap[content] = append(fileMap[content], root+"/"+name)
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
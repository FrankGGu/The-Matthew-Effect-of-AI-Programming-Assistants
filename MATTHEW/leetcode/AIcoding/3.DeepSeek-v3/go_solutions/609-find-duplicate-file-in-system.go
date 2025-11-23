func findDuplicate(paths []string) [][]string {
    contentMap := make(map[string][]string)

    for _, path := range paths {
        parts := strings.Split(path, " ")
        dir := parts[0]
        for i := 1; i < len(parts); i++ {
            file := parts[i]
            left := strings.Index(file, "(")
            right := strings.Index(file, ")")
            content := file[left+1 : right]
            filename := file[:left]
            fullPath := dir + "/" + filename
            contentMap[content] = append(contentMap[content], fullPath)
        }
    }

    var result [][]string
    for _, paths := range contentMap {
        if len(paths) > 1 {
            result = append(result, paths)
        }
    }

    return result
}
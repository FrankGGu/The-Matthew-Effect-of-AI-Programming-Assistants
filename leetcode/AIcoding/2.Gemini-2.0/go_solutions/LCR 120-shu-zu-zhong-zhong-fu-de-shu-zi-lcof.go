func findDuplicate(paths []string) [][]string {
	fileMap := make(map[string][]string)
	for _, path := range paths {
		parts := strings.Split(path, " ")
		dir := parts[0]
		for i := 1; i < len(parts); i++ {
			fileInfo := parts[i]
			openParen := strings.Index(fileInfo, "(")
			closeParen := strings.Index(fileInfo, ")")
			fileName := fileInfo[:openParen]
			content := fileInfo[openParen+1 : closeParen]
			fileMap[content] = append(fileMap[content], dir+"/"+fileName)
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
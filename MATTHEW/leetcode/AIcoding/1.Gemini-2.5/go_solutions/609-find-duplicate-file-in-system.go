func findDuplicate(paths []string) [][]string {
	contentToFilePaths := make(map[string][]string)

	for _, path := range paths {
		parts := strings.Fields(path)
		dir := parts[0]

		for i := 1; i < len(parts); i++ {
			fileInfo := parts[i]

			// Find the index of '('
			idx := strings.Index(fileInfo, "(")

			filename := fileInfo[:idx]
			content := fileInfo[idx+1 : len(fileInfo)-1] // Extract content between '(' and ')'

			fullPath := dir + "/" + filename
			contentToFilePaths[content] = append(contentToFilePaths[content], fullPath)
		}
	}

	var result [][]string
	for _, filePaths := range contentToFilePaths {
		if len(filePaths) > 1 {
			result = append(result, filePaths)
		}
	}

	return result
}
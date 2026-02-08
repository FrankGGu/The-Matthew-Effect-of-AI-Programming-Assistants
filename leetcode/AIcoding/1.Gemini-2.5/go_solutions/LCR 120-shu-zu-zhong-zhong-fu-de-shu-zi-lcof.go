func findDuplicate(paths []string) [][]string {
	contentMap := make(map[string][]string)

	for _, pathStr := range paths {
		parts := strings.Split(pathStr, " ")
		baseDir := parts[0]

		for i :=
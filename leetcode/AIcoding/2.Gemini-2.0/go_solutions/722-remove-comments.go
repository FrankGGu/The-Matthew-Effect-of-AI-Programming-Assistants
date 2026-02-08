func removeComments(source []string) []string {
	result := make([]string, 0)
	inBlock := false
	for _, line := range source {
		i := 0
		newLine := ""
		for i < len(line) {
			if inBlock {
				if i+1 < len(line) && line[i:i+2] == "*/" {
					inBlock = false
					i += 2
				} else {
					i++
				}
			} else {
				if i+1 < len(line) && line[i:i+2] == "/*" {
					inBlock = true
					i += 2
				} else if i+1 < len(line) && line[i:i+2] == "//" {
					break
				} else {
					newLine += string(line[i])
					i++
				}
			}
		}
		if !inBlock && len(newLine) > 0 {
			result = append(result, newLine)
		}
	}
	return result
}
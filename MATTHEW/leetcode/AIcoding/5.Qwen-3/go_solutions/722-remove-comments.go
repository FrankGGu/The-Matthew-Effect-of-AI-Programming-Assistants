package main

func removeComments(source []string) []string {
	var result []string
	inBlock := false
	var line []rune

	for _, s := range source {
		for i := 0; i < len(s); i++ {
			if inBlock {
				if s[i] == '*' && i+1 < len(s) && s[i+1] == '/' {
					inBlock = false
					i++
				}
			} else {
				if s[i] == '/' && i+1 < len(s) && s[i+1] == '*' {
					inBlock = true
					i++
				} else if s[i] == '/' && i+1 < len(s) && s[i+1] == '/' {
					break
				} else {
					line = append(line, rune(s[i]))
				}
			}
		}
		if !inBlock && len(line) > 0 {
			result = append(result, string(line))
			line = nil
		}
	}
	return result
}
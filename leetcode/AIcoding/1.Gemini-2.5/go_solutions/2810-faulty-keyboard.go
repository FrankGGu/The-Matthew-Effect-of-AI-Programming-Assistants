func finalString(s string) string {
	var sb strings.Builder
	for _, char := range s {
		if char == 'i' {
			currentContent := sb.String()
			reversedContent := reverseString(currentContent)
			sb.Reset()
			sb.WriteString(reversedContent)
		} else {
			sb.WriteRune(char)
		}
	}
	return sb.String()
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}
func mergeAlternately(word1 string, word2 string) string {
	var sb strings.Builder
	len1 := len(word1)
	len2 := len(word2)
	i, j := 0, 0

	for i < len1 || j < len2 {
		if i < len1 {
			sb.WriteByte(word1[i])
			i++
		}
		if j < len2 {
			sb.WriteByte(word2[j])
			j++
		}
	}

	return sb.String()
}
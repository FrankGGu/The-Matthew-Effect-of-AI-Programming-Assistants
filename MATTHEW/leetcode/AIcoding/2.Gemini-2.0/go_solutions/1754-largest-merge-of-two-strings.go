func largestMerge(word1 string, word2 string) string {
	i, j := 0, 0
	res := ""
	for i < len(word1) && j < len(word2) {
		if word1[i:] > word2[j:] {
			res += string(word1[i])
			i++
		} else {
			res += string(word2[j])
			j++
		}
	}
	res += word1[i:]
	res += word2[j:]
	return res
}
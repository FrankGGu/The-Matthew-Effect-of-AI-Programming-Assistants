func canMakeSubsequence(str1 string, str2 string) bool {
	i, j := 0, 0
	for i < len(str1) && j < len(str2) {
		if str1[i] == str2[j] {
			j++
		} else if (str1[i]-'a'+1)%26 == (str2[j] - 'a') {
			j++
		}
		i++
	}
	return j == len(str2)
}
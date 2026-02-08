func removeAnagrams(words []string) []string {
	result := []string{}
	if len(words) == 0 {
		return result
	}

	result = append(result, words[0])
	prevSignature := getSignature(words[0])

	for i := 1; i < len(words); i++ {
		currSignature := getSignature(words[i])
		if currSignature != prevSignature {
			result = append(result, words[i])
			prevSignature = currSignature
		}
	}

	return result
}

func getSignature(s string) string {
	count := make([]int, 26)
	for _, char := range s {
		count[char-'a']++
	}

	signature := ""
	for i := 0; i < 26; i++ {
		if count[i] > 0 {
			signature += string(rune('a'+i)) + string(count[i]+'0')
		}
	}
	return signature
}
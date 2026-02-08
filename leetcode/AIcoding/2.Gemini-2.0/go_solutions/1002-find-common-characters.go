func commonChars(A []string) []string {
	first := A[0]
	count := make([]int, 26)
	for _, c := range first {
		count[c-'a']++
	}

	for i := 1; i < len(A); i++ {
		tempCount := make([]int, 26)
		for _, c := range A[i] {
			tempCount[c-'a']++
		}

		for j := 0; j < 26; j++ {
			if tempCount[j] < count[j] {
				count[j] = tempCount[j]
			}
		}
	}

	result := []string{}
	for i := 0; i < 26; i++ {
		for j := 0; j < count[i]; j++ {
			result = append(result, string(rune('a'+i)))
		}
	}

	return result
}
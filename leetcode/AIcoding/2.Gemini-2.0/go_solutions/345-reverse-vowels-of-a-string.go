func reverseVowels(s string) string {
	vowels := "aeiouAEIOU"
	vowelIndices := []int{}
	for i, char := range s {
		if strings.ContainsRune(vowels, char) {
			vowelIndices = append(vowelIndices, i)
		}
	}

	sBytes := []byte(s)
	for i := 0; i < len(vowelIndices)/2; i++ {
		sBytes[vowelIndices[i]], sBytes[vowelIndices[len(vowelIndices)-1-i]] = sBytes[vowelIndices[len(vowelIndices)-1-i]], sBytes[vowelIndices[i]]
	}

	return string(sBytes)
}
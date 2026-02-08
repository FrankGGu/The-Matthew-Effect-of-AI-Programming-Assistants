package main

func groupAnagrams(strs []string) [][]string {
	anagramMap := make(map[[26]int][]string)

	for _, str := range strs {
		var charCount [26]int
		for _, char := range str {
			charCount[char-'a']++
		}
		anagramMap[charCount] = append(anagramMap[charCount], str)
	}

	result := make([][]string, 0, len(anagramMap))
	for _, group := range anagramMap {
		result = append(result, group)
	}

	return result
}
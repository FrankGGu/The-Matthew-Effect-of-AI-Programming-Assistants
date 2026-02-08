func canConstruct(ransomNote string, magazine string) bool {
	counts := [26]int{}

	for _, char := range magazine {
		counts[char-'a']++
	}

	for _, char := range ransomNote {
		counts[char-'a']--
		if counts[char-'a'] < 0 {
			return false
		}
	}

	return true
}
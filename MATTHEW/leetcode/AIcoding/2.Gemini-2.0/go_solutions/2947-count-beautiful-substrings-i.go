func countVowels(s string) int {
	count := 0
	for _, r := range s {
		if r == 'a' || r == 'e' || r == 'i' || r == 'o' || r == 'u' {
			count++
		}
	}
	return count
}

func countBeautifulSubstrings(s string, k int) int {
	count := 0
	for i := 0; i < len(s); i++ {
		for j := i; j < len(s); j++ {
			sub := s[i : j+1]
			vowels := countVowels(sub)
			consonants := len(sub) - vowels
			if vowels == consonants && (vowels*consonants)%k == 0 {
				count++
			}
		}
	}
	return count
}
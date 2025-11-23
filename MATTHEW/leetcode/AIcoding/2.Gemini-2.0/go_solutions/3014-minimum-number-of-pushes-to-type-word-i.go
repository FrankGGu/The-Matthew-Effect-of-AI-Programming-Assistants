func minimumPushes(word string) int {
	count := make([]int, 26)
	for _, char := range word {
		count[char-'a']++
	}

	ans := 0
	for i := 0; i < len(word); i++ {
		if i < 8 {
			ans++
		} else if i < 16 {
			ans += 2
		} else if i < 24 {
			ans += 3
		} else {
			ans += 4
		}
	}

	return ans
}
package main

func firstPalindrome(words []string) string {
	for _, word := range words {
		left, right := 0, len(word)-1
		isPalindrome := true
		for left < right {
			if word[left] != word[right] {
				isPalindrome = false
				break
			}
			left++
			right--
		}
		if isPalindrome {
			return word
		}
	}
	return ""
}
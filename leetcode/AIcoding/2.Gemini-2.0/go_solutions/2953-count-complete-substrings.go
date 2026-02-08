func countCompleteSubstrings(word string, k int) int {
	n := len(word)
	ans := 0

	for length := 1; length <= 26; length++ {
		for charCount := 1; charCount <= n/length; charCount++ {
			targetLength := length * charCount
			if targetLength > n {
				break
			}

			for i := 0; i <= n-targetLength; i++ {
				sub := word[i : i+targetLength]
				counts := make(map[rune]int)
				isComplete := true
				for _, char := range sub {
					counts[char]++
				}

				for _, count := range counts {
					if count != charCount {
						isComplete = false
						break
					}
				}

				if isComplete {
					isDistinct := true
					distinctChars := make(map[rune]bool)
					for _, char := range sub {
						if _, ok := distinctChars[char]; !ok {
							distinctChars[char] = true
						}
					}
					if len(distinctChars) != length {
						isDistinct = false
					}

					if isComplete && isDistinct {
						ans++
					}
				}
			}
		}
	}

	return ans
}
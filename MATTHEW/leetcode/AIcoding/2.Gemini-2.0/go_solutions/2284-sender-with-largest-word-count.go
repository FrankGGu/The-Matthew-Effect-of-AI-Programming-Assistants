func largestWordCount(messages []string, senders []string) string {
	wordCount := make(map[string]int)
	for i := 0; i < len(messages); i++ {
		words := strings.Split(messages[i], " ")
		wordCount[senders[i]] += len(words)
	}

	maxCount := 0
	result := ""
	for sender, count := range wordCount {
		if count > maxCount {
			maxCount = count
			result = sender
		} else if count == maxCount {
			if sender > result {
				result = sender
			}
		}
	}

	return result
}
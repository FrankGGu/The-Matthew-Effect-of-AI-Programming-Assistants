func largestWordCount(messages []string, senders []string) string {
	senderCounts := make(map[string]int)

	for i := 0; i < len(messages); i++ {
		wordCount := len(strings.Fields(messages[i]))
		senderCounts[senders[i]] += wordCount
	}

	maxCount := 0
	resultSender := ""

	for sender, count := range senderCounts {
		if count > maxCount {
			maxCount = count
			resultSender = sender
		} else if count == maxCount {
			if sender > resultSender {
				resultSender = sender
			}
		}
	}

	return resultSender
}
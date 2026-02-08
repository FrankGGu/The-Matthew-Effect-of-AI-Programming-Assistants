func largestWordCount(messages []string, senders []string) string {
    senderWordCount := make(map[string]int)
    maxCount := 0
    var result string

    for i, sender := range senders {
        words := strings.Fields(messages[i])
        count := len(words)
        senderWordCount[sender] += count
        if senderWordCount[sender] > maxCount || 
           (senderWordCount[sender] == maxCount && sender > result) {
            maxCount = senderWordCount[sender]
            result = sender
        }
    }

    return result
}
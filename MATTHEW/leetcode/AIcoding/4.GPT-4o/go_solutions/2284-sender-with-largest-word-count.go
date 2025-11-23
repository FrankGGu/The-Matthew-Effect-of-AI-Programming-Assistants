func largestWordCount(messages []string, senders []string) string {
    countMap := make(map[string]int)
    maxCount := 0
    senderWithMaxCount := ""

    for i, msg := range messages {
        wordCount := len(strings.Fields(msg))
        countMap[senders[i]] += wordCount

        if countMap[senders[i]] > maxCount || (countMap[senders[i]] == maxCount && senders[i] > senderWithMaxCount) {
            maxCount = countMap[senders[i]]
            senderWithMaxCount = senders[i]
        }
    }

    return senderWithMaxCount
}
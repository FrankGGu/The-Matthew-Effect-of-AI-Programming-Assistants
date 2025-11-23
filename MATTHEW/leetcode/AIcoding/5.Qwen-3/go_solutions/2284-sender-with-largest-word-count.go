package main

func largestWordCount(messages []string, senders []string) string {
    count := make(map[string]int)
    maxCount := 0
    result := ""

    for i := 0; i < len(messages); i++ {
        words := len(strings.Split(messages[i], " "))
        count[senders[i]] += words
        if count[senders[i]] > maxCount {
            maxCount = count[senders[i]]
            result = senders[i]
        } else if count[senders[i]] == maxCount && senders[i] < result {
            result = senders[i]
        }
    }

    return result
}
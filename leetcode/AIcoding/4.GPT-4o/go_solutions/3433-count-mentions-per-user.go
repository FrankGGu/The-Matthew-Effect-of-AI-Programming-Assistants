func countMentions(messages []string, user string) int {
    count := 0
    for _, message := range messages {
        if strings.Contains(message, "@"+user) {
            count++
        }
    }
    return count
}
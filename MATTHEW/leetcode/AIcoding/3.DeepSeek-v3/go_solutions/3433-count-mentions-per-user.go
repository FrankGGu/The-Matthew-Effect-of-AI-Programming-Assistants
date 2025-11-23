func countMentions(tweets []string) map[string]int {
    mentions := make(map[string]int)
    for _, tweet := range tweets {
        words := strings.Fields(tweet)
        for _, word := range words {
            if strings.HasPrefix(word, "@") {
                username := word[1:]
                mentions[username]++
            }
        }
    }
    return mentions
}
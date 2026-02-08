package main

func countMentionsPerUser(mentions []string) map[string]int {
    result := make(map[string]int)
    for _, mention := range mentions {
        if len(mention) < 2 || mention[0] != '@' {
            continue
        }
        user := mention[1:]
        result[user]++
    }
    return result
}
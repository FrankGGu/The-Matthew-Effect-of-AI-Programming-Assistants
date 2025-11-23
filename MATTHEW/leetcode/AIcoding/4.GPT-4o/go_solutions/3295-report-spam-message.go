func reportSpam(messages []string, spamWords []string) []string {
    spamSet := make(map[string]struct{})
    for _, word := range spamWords {
        spamSet[word] = struct{}{}
    }

    result := []string{}
    for _, message := range messages {
        isSpam := false
        for _, word := range strings.Fields(message) {
            if _, found := spamSet[word]; found {
                isSpam = true
                break
            }
        }
        if isSpam {
            result = append(result, message)
        }
    }
    return result
}
func mostCommonResponse(responses []string) string {
    count := make(map[string]int)
    maxCount := 0
    mostCommon := ""

    for _, response := range responses {
        count[response]++
        if count[response] > maxCount {
            maxCount = count[response]
            mostCommon = response
        }
    }

    return mostCommon
}
func countMatches(items [][]string, ruleKey string, ruleValue string) int {
    var index int
    switch ruleKey {
    case "type":
        index = 0
    case "color":
        index = 1
    case "name":
        index = 2
    }

    count := 0
    for _, item := range items {
        if item[index] == ruleValue {
            count++
        }
    }
    return count
}
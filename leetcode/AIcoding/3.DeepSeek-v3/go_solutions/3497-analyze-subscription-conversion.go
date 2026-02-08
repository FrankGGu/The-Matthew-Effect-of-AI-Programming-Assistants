func analyzeConversion(logs [][]string) []string {
    subscriptionMap := make(map[string]map[string]bool)
    for _, log := range logs {
        user, action := log[0], log[1]
        if _, exists := subscriptionMap[user]; !exists {
            subscriptionMap[user] = make(map[string]bool)
        }
        subscriptionMap[user][action] = true
    }

    var result []string
    for user, actions := range subscriptionMap {
        if actions["PURCHASE"] {
            if actions["SUBSCRIBE"] {
                result = append(result, user)
            }
        }
    }
    sort.Strings(result)
    return result
}
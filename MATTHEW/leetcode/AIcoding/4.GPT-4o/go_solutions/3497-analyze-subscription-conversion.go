func analyzeSubscriptionConversion(users [][]int) float64 {
    totalUsers := len(users)
    if totalUsers == 0 {
        return 0.0
    }

    convertedUsers := 0
    for _, user := range users {
        if user[1] == 1 {
            convertedUsers++
        }
    }

    return float64(convertedUsers) / float64(totalUsers)
}
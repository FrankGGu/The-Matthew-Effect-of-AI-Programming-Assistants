func calculateMoney(n int) int {
    totalMoney := 0
    currentMondayValue := 1 // Amount to save on the current week's Monday
    dayOfWeek := 1          // 1 for Monday, 7 for Sunday

    for i := 0; i < n; i++ {
        totalMoney += currentMondayValue + (dayOfWeek - 1)
        dayOfWeek++
        if dayOfWeek > 7 {
            dayOfWeek = 1
            currentMondayValue++
        }
    }

    return totalMoney
}
func dayOfYear(date string) int {
    monthDays := []int{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    year, month, day := 0, 0, 0
    fmt.Sscanf(date, "%d-%d-%d", &year, &month, &day)

    if (year%4 == 0 && year%100 != 0) || (year%400 == 0) {
        monthDays[1] = 29
    }

    dayOfYear := day
    for i := 0; i < month-1; i++ {
        dayOfYear += monthDays[i]
    }

    return dayOfYear
}
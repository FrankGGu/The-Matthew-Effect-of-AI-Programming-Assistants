func dayOfYear(date string) int {
    year, _ := strconv.Atoi(date[:4])
    month, _ := strconv.Atoi(date[5:7])
    day, _ := strconv.Atoi(date[8:10])

    daysInMonth := []int{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    if isLeap(year) {
        daysInMonth[1] = 29
    }

    dayOfYear := 0
    for i := 0; i < month-1; i++ {
        dayOfYear += daysInMonth[i]
    }
    dayOfYear += day

    return dayOfYear
}

func isLeap(year int) bool {
    if year % 4 != 0 {
        return false
    } else if year % 100 != 0 {
        return true
    } else {
        return year % 400 == 0
    }
}
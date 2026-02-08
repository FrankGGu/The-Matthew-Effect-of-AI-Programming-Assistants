func dayOfTheWeek(day int, month int, year int) string {
    days := []string{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
    if month < 3 {
        month += 12
        year--
    }
    k := year % 100
    j := year / 100
    f := day + (13*(month+1))/5 + k + k/4 + j/4 + 5*j
    return days[f%7]
}
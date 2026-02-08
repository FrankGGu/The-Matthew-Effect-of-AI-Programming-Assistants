func dayOfTheWeek(day int, month int, year int) string {
    days := []string{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
    if month < 3 {
        month += 12
        year--
    }
    c := year / 100
    y := year % 100
    w := (y + y/4 + c/4 - 2*c + 26*(month+1)/10 + day - 1) % 7
    if w < 0 {
        w += 7
    }
    return days[w]
}
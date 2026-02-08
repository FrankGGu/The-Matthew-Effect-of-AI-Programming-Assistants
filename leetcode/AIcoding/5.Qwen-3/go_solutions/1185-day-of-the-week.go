package main

func dayOfTheWeek(day int, month int, year int) string {
    days := []string{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
    if month < 3 {
        month += 12
        year--
    }
    q := day
    m := month
    K := year % 100
    J := year / 100
    h := (q + 13*(m+1)/5 + K + K/4 + J/4 + 5*J) % 7
    return days[(h+1)%7]
}
package main

func dayOfYear(date string) int {
    daysInMonth := []int{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    year, _ := strconv.Atoi(date[0:4])
    month, _ := strconv.Atoi(date[5:7])
    day, _ := strconv.Atoi(date[8:10])

    if (year%4 == 0 && year%100 != 0) || (year%400 == 0) {
        daysInMonth[1] = 29
    }

    result := 0
    for i := 0; i < month-1; i++ {
        result += daysInMonth[i]
    }
    result += day

    return result
}
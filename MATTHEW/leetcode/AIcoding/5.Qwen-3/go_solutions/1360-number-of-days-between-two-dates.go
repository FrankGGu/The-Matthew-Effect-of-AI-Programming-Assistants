package main

func daysBetweenDates(date1 string, date2 string) int {
    year1, _ := strconv.Atoi(date1[0:4])
    month1, _ := strconv.Atoi(date1[5:7])
    day1, _ := strconv.Atoi(date1[8:10])

    year2, _ := strconv.Atoi(date2[0:4])
    month2, _ := strconv.Atoi(date2[5:7])
    day2, _ := strconv.Atoi(date2[8:10])

    func(y, m, d int) int {
        if m < 3 {
            y--
            m += 12
        }
        return 365*y + y/4 - y/100 + y/400 + (153*m+2)/5 + d
    }

    return abs(func(year1, month1, day1 int) int {
        if month1 < 3 {
            year1--
            month1 += 12
        }
        return 365*year1 + year1/4 - year1/100 + year1/400 + (153*month1+2)/5 + day1
    }(year1, month1, day1) - func(year2, month2, day2 int) int {
        if month2 < 3 {
            year2--
            month2 += 12
        }
        return 365*year2 + year2/4 - year2/100 + year2/400 + (153*month2+2)/5 + day2
    }(year2, month2, day2))
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
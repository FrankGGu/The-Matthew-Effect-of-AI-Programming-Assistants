func countDaysTogether(arriveAlice []string, leaveAlice []string, arriveBob []string, leaveBob []string) int {
    aliceStart := max(arriveAlice, arriveBob)
    aliceEnd := min(leaveAlice, leaveBob)

    if aliceStart > aliceEnd {
        return 0
    }

    return daysBetween(aliceStart, aliceEnd)
}

func max(date1 []string, date2 []string) string {
    if date1[0] > date2[0] || (date1[0] == date2[0] && date1[1] > date2[1]) || (date1[0] == date2[0] && date1[1] == date2[1] && date1[2] > date2[2]) {
        return date1[0]
    }
    return date2[0]
}

func min(date1 []string, date2 []string) string {
    if date1[0] < date2[0] || (date1[0] == date2[0] && date1[1] < date2[1]) || (date1[0] == date2[0] && date1[1] == date2[1] && date1[2] < date2[2]) {
        return date1[0]
    }
    return date2[0]
}

func daysBetween(start string, end string) int {
    startYear, startMonth, startDay := parseDate(start)
    endYear, endMonth, endDay := parseDate(end)

    startDate := time.Date(startYear, time.Month(startMonth), startDay, 0, 0, 0, 0, time.UTC)
    endDate := time.Date(endYear, time.Month(endMonth), endDay, 0, 0, 0, 0, time.UTC)

    return int(endDate.Sub(startDate).Hours()/24) + 1
}

func parseDate(date string) (int, int, int) {
    year, month, day := 0, 0, 0
    fmt.Sscanf(date, "%d-%d-%d", &year, &month, &day)
    return year, month, day
}
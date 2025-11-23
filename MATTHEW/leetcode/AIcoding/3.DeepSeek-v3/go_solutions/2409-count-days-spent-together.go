func countDaysTogether(arriveAlice string, leaveAlice string, arriveBob string, leaveBob string) int {
    daysInMonth := []int{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

    parseDate := func(date string) (month, day int) {
        parts := strings.Split(date, "-")
        month, _ = strconv.Atoi(parts[0])
        day, _ = strconv.Atoi(parts[1])
        return
    }

    dateToDays := func(month, day int) int {
        total := 0
        for i := 0; i < month-1; i++ {
            total += daysInMonth[i]
        }
        return total + day
    }

    aliceArriveMonth, aliceArriveDay := parseDate(arriveAlice)
    aliceLeaveMonth, aliceLeaveDay := parseDate(leaveAlice)
    bobArriveMonth, bobArriveDay := parseDate(arriveBob)
    bobLeaveMonth, bobLeaveDay := parseDate(leaveBob)

    aliceArriveDays := dateToDays(aliceArriveMonth, aliceArriveDay)
    aliceLeaveDays := dateToDays(aliceLeaveMonth, aliceLeaveDay)
    bobArriveDays := dateToDays(bobArriveMonth, bobArriveDay)
    bobLeaveDays := dateToDays(bobLeaveMonth, bobLeaveDay)

    start := max(aliceArriveDays, bobArriveDays)
    end := min(aliceLeaveDays, bobLeaveDays)

    if start > end {
        return 0
    }
    return end - start + 1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
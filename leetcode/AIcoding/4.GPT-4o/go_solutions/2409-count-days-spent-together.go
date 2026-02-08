func countDaysTogether(arriveAlice string, leaveAlice string, arriveBob string, leaveBob string) int {
    daysInMonth := map[int]int{1: 31, 2: 28, 3: 31, 4: 30, 5: 31, 6: 30, 7: 31, 8: 31, 9: 30, 10: 31, 11: 30, 12: 31}

    getDays := func(date string) int {
        month, day := 0, 0
        fmt.Sscanf(date, "%d-%d", &month, &day)
        totalDays := day
        for m := 1; m < month; m++ {
            totalDays += daysInMonth[m]
        }
        return totalDays
    }

    startAlice := getDays(arriveAlice)
    endAlice := getDays(leaveAlice)
    startBob := getDays(arriveBob)
    endBob := getDays(leaveBob)

    start := max(startAlice, startBob)
    end := min(endAlice, endBob)

    return max(0, end-start+1)
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
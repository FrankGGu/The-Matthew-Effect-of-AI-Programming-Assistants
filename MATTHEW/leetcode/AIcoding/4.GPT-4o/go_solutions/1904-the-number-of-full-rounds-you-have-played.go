func numberOfRounds(startTime string, finishTime string) int {
    startHour, startMinute := parseTime(startTime)
    finishHour, finishMinute := parseTime(finishTime)

    if finishHour < startHour || (finishHour == startHour && finishMinute < startMinute) {
        finishHour += 24
    }

    startTotalMinutes := startHour*60 + startMinute
    finishTotalMinutes := finishHour*60 + finishMinute

    if finishTotalMinutes < startTotalMinutes {
        return 0
    }

    startRound := (startTotalMinutes + 15) / 15
    finishRound := finishTotalMinutes / 15

    return finishRound - startRound
}

func parseTime(timeStr string) (int, int) {
    var hour, minute int
    fmt.Sscanf(timeStr, "%02d:%02d", &hour, &minute)
    return hour, minute
}
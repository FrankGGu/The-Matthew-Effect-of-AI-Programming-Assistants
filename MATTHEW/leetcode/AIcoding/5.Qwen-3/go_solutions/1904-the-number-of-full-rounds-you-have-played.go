package main

func numberOfFullRounds(startTime string, endTime string) int {
    startHour, _ := strconv.Atoi(startTime[:2])
    startMin, _ := strconv.Atoi(startTime[3:5])
    endHour, _ := strconv.Atoi(endTime[:2])
    endMin, _ := strconv.Atoi(endTime[3:5])

    startTotal := startHour*60 + startMin
    endTotal := endHour*60 + endMin

    if startTotal > endTotal {
        endTotal += 24 * 60
    }

    fullRounds := (endTotal - startTotal) / 60
    return fullRounds
}
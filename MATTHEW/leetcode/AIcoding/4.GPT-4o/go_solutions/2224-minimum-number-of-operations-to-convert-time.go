func convertTime(current string, correct string) int {
    currentMinutes := convertToMinutes(current)
    correctMinutes := convertToMinutes(correct)
    diff := correctMinutes - currentMinutes
    operations := 0

    for _, op := range []int{60, 15, 5, 1} {
        operations += diff / op
        diff %= op
    }

    return operations
}

func convertToMinutes(time string) int {
    parts := strings.Split(time, ":")
    hours, _ := strconv.Atoi(parts[0])
    minutes, _ := strconv.Atoi(parts[1])
    return hours*60 + minutes
}
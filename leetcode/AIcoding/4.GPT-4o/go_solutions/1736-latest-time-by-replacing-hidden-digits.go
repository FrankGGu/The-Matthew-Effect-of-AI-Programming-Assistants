func maximumTime(time string) string {
    timeRunes := []rune(time)

    if timeRunes[0] == '?' {
        if timeRunes[1] == '?' || timeRunes[1] < '4' {
            timeRunes[0] = '2'
        } else {
            timeRunes[0] = '1'
        }
    }
    if timeRunes[1] == '?' {
        if timeRunes[0] == '2' {
            timeRunes[1] = '3'
        } else {
            timeRunes[1] = '9'
        }
    }
    if timeRunes[3] == '?' {
        timeRunes[3] = '5'
    }
    if timeRunes[4] == '?' {
        timeRunes[4] = '9'
    }

    return string(timeRunes)
}
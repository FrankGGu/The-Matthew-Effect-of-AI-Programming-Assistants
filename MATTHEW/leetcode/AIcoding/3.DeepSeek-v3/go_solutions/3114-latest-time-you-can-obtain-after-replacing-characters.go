func maximumTime(time string) string {
    timeBytes := []byte(time)
    if timeBytes[0] == '?' {
        if timeBytes[1] == '?' || timeBytes[1] <= '3' {
            timeBytes[0] = '2'
        } else {
            timeBytes[0] = '1'
        }
    }
    if timeBytes[1] == '?' {
        if timeBytes[0] == '2' {
            timeBytes[1] = '3'
        } else {
            timeBytes[1] = '9'
        }
    }
    if timeBytes[3] == '?' {
        timeBytes[3] = '5'
    }
    if timeBytes[4] == '?' {
        timeBytes[4] = '9'
    }
    return string(timeBytes)
}
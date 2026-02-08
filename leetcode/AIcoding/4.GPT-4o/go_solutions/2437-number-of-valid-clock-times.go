func countTime(time string) int {
    hours := 0
    minutes := 0

    if time[0] == '?' {
        if time[1] == '?' {
            hours = 24
        } else if time[1] < '4' {
            hours = 3
        } else {
            hours = 2
        }
    } else if time[1] == '?' {
        if time[0] == '2' {
            hours = 4
        } else {
            hours = 10
        }
    } else {
        hours = 1
    }

    if time[3] == '?' {
        if time[4] == '?' {
            minutes = 60
        } else {
            minutes = 6
        }
    } else if time[4] == '?' {
        minutes = 10
    } else {
        minutes = 1
    }

    return hours * minutes
}
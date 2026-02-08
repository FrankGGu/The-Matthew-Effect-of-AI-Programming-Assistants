func countTime(time string) int {
    count := 1
    if time[0] == '?' && time[1] == '?' {
        count *= 24
    } else if time[0] == '?' {
        if time[1] < '4' {
            count *= 3
        } else {
            count *= 2
        }
    } else if time[1] == '?' {
        if time[0] == '2' {
            count *= 4
        } else {
            count *= 10
        }
    }

    if time[3] == '?' {
        count *= 6
    }

    if time[4] == '?' {
        count *= 10
    }

    return count
}
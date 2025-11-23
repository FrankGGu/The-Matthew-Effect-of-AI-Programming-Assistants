package main

func countTime(time string) int {
    var result int
    for h := 0; h <= 23; h++ {
        for m := 0; m <= 59; m++ {
            if validTime(time, h, m) {
                result++
            }
        }
    }
    return result
}

func validTime(time string, h, m int) bool {
    hourStr := ""
    if h < 10 {
        hourStr += "0"
    }
    hourStr += strconv.Itoa(h)
    minuteStr := ""
    if m < 10 {
        minuteStr += "0"
    }
    minuteStr += strconv.Itoa(m)
    for i := 0; i < 5; i++ {
        if time[i] == '?' {
            continue
        }
        if i < 2 {
            if hourStr[i] != time[i] {
                return false
            }
        } else {
            if minuteStr[i-2] != time[i] {
                return false
            }
        }
    }
    return true
}
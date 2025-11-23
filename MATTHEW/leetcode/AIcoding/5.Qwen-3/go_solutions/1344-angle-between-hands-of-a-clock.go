package main

func angleClock(hour int, minutes int) float64 {
    hourAngle := float64(hour%12)*30 + float64(minutes)*0.5
    minuteAngle := float64(minutes) * 6
    diff := abs(hourAngle - minuteAngle)
    if diff > 180 {
        diff = 360 - diff
    }
    return diff
}

func abs(x float64) float64 {
    if x < 0 {
        return -x
    }
    return x
}
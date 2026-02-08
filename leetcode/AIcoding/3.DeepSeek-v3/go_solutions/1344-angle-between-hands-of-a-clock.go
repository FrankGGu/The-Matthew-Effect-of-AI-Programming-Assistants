func angleClock(hour int, minutes int) float64 {
    hourAngle := float64(hour%12)*30 + float64(minutes)*0.5
    minuteAngle := float64(minutes) * 6
    diff := math.Abs(hourAngle - minuteAngle)
    if diff > 180 {
        return 360 - diff
    }
    return diff
}
package main

func addTime(time string, waitMinutes int) string {
    hours := int(time[0] - '0')*10 + int(time[1] - '0')
    minutes := int(time[3] - '0')*10 + int(time[4] - '0')
    totalMinutes := hours*60 + minutes + waitMinutes
    newHours := totalMinutes / 60
    newMinutes := totalMinutes % 60
    if newHours >= 24 {
        newHours -= 24
    }
    return fmt.Sprintf("%02d:%02d", newHours, newMinutes)
}
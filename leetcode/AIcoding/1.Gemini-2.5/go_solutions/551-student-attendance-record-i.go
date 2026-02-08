func checkRecord(s string) bool {
    absentCount := 0
    lateConsecutiveCount := 0

    for _, char := range s {
        if char == 'A' {
            absentCount++
            lateConsecutiveCount = 0
            if absentCount >= 2 {
                return false
            }
        } else if char == 'L' {
            lateConsecutiveCount++
            if lateConsecutiveCount >= 3 {
                return false
            }
        } else { // char == 'P'
            lateConsecutiveCount = 0
        }
    }

    return true
}
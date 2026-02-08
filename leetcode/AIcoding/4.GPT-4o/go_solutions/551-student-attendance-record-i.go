func checkRecord(s string) bool {
    aCount := 0
    lCount := 0

    for i := 0; i < len(s); i++ {
        if s[i] == 'A' {
            aCount++
        }
        if s[i] == 'L' {
            lCount++
            if lCount > 2 {
                return false
            }
        } else {
            lCount = 0
        }
    }

    return aCount < 2
}
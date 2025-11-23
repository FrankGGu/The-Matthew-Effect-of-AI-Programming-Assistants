func checkRecord(s string) bool {
    absent := 0
    late := 0

    for _, ch := range s {
        if ch == 'A' {
            absent++
            if absent >= 2 {
                return false
            }
            late = 0
        } else if ch == 'L' {
            late++
            if late >= 3 {
                return false
            }
        } else {
            late = 0
        }
    }

    return true
}
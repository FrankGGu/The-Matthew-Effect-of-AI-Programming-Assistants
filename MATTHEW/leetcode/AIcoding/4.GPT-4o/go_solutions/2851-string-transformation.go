func canTransform(start string, end string) bool {
    if len(start) != len(end) {
        return false
    }

    sCount, eCount := 0, 0
    for i := 0; i < len(start); i++ {
        if start[i] == 'X' {
            sCount++
        }
        if end[i] == 'X' {
            eCount++
        }
    }

    if sCount != eCount {
        return false
    }

    j := len(end) - 1
    for i := len(start) - 1; i >= 0; i-- {
        if start[i] == 'X' {
            continue
        }
        if j < 0 || start[i] != end[j] {
            return false
        }
        if end[j] == 'L' {
            if i < j {
                return false
            }
        }
        if end[j] == 'R' {
            if i > j {
                return false
            }
        }
        j--
    }

    return true
}
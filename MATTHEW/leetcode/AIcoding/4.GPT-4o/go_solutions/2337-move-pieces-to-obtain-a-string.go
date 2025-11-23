func canTransform(start string, end string) bool {
    if len(start) != len(end) {
        return false
    }

    sCount, eCount := 0, 0
    for i := 0; i < len(start); i++ {
        if start[i] != 'X' {
            sCount++
        }
        if end[i] != 'X' {
            eCount++
        }
        if sCount > eCount {
            return false
        }
    }

    sIndex, eIndex := 0, 0
    for sIndex < len(start) && eIndex < len(end) {
        for sIndex < len(start) && start[sIndex] == 'X' {
            sIndex++
        }
        for eIndex < len(end) && end[eIndex] == 'X' {
            eIndex++
        }

        if sIndex < len(start) && eIndex < len(end) {
            if start[sIndex] != end[eIndex] || 
               (start[sIndex] == 'L' && sIndex < eIndex) || 
               (start[sIndex] == 'R' && sIndex > eIndex) {
                return false
            }
            sIndex++
            eIndex++
        }
    }

    return true
}
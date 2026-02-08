func minNumberOfFrogs(croakOfFrogs string) int {
    count := [5]int{}
    maxFrogs := 0
    for _, ch := range croakOfFrogs {
        switch ch {
        case 'c':
            count[0]++
        case 'r':
            if count[0] == 0 {
                return -1
            }
            count[1]++
        case 'o':
            if count[1] == 0 {
                return -1
            }
            count[2]++
        case 'a':
            if count[2] == 0 {
                return -1
            }
            count[3]++
        case 'k':
            if count[3] == 0 {
                return -1
            }
            count[4]++
            count[0]--
            count[1]--
            count[2]--
            count[3]--
        default:
            return -1
        }
        maxFrogs = max(maxFrogs, count[0]+count[1]+count[2]+count[3])
    }
    if count[0] == 0 && count[1] == 0 && count[2] == 0 && count[3] == 0 {
        return maxFrogs
    }
    return -1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
func minNumberOfFrogs(croakOfFrogs string) int {
    count := make([]int, 5)
    res, frogs := 0, 0
    for _, ch := range croakOfFrogs {
        idx := strings.Index("croak", string(ch))
        count[idx]++
        if idx == 0 {
            frogs++
            if frogs > res {
                res = frogs
            }
        } else {
            count[idx-1]--
            if count[idx-1] < 0 {
                return -1
            }
            if idx == 4 {
                frogs--
            }
        }
    }
    for i := 0; i < 4; i++ {
        if count[i] != 0 {
            return -1
        }
    }
    return res
}
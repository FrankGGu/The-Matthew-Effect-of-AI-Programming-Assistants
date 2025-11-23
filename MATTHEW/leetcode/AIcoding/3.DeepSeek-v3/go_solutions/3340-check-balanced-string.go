func checkValidString(s string) bool {
    minOpen, maxOpen := 0, 0
    for _, ch := range s {
        if ch == '(' {
            minOpen++
            maxOpen++
        } else if ch == ')' {
            minOpen = max(minOpen-1, 0)
            maxOpen--
            if maxOpen < 0 {
                return false
            }
        } else {
            minOpen = max(minOpen-1, 0)
            maxOpen++
        }
    }
    return minOpen == 0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
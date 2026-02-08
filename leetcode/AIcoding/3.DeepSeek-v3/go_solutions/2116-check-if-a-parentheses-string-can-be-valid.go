func canBeValid(s string, locked string) bool {
    n := len(s)
    if n%2 != 0 {
        return false
    }

    minOpen, maxOpen := 0, 0
    for i := 0; i < n; i++ {
        if locked[i] == '1' {
            if s[i] == '(' {
                minOpen++
                maxOpen++
            } else {
                minOpen--
                maxOpen--
            }
        } else {
            minOpen--
            maxOpen++
        }
        if maxOpen < 0 {
            return false
        }
        if minOpen < 0 {
            minOpen = 0
        }
    }
    return minOpen == 0
}
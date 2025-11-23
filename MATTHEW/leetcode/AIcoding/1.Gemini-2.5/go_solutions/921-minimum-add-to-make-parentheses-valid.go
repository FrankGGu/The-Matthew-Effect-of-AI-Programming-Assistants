func minAddToMakeValid(s string) int {
    openNeeded := 0
    closeNeeded := 0

    for _, char := range s {
        if char == '(' {
            openNeeded++
        } else { // char == ')'
            if openNeeded > 0 {
                openNeeded--
            } else {
                closeNeeded++
            }
        }
    }

    return openNeeded + closeNeeded
}
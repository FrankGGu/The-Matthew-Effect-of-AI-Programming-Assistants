func minimumChairs(s string) int {
    maxChairs := 0
    currentChairs := 0
    for _, char := range s {
        if char == 'E' {
            currentChairs++
            if currentChairs > maxChairs {
                maxChairs = currentChairs
            }
        } else if char == 'L' {
            currentChairs--
        }
    }
    return maxChairs
}
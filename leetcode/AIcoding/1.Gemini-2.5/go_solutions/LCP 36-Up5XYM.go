func hasGroupsSizeX(deck []int) bool {
    if len(deck) < 2 {
        return false
    }

    counts := make(map[int]int)
    for _, card := range deck {
        counts[card]++
    }

    // Function to calculate GCD
    var calculateGCD func(a, b int) int
    calculateGCD = func(a, b int) int {
        for b != 0 {
            a, b = b, a%b
        }
        return a
    }

    // Initialize the overall GCD with the first count encountered
    // Since len(deck) >= 2, counts map will not be empty.
    currentGCD := 0
    for _, count := range counts {
        if currentGCD == 0 {
            currentGCD = count
        } else {
            currentGCD = calculateGCD(currentGCD, count)
        }
    }

    return currentGCD >= 2
}
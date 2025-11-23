func minimumRecolors(blocks string, k int) int {
    n := len(blocks)

    currentWCount := 0
    for i := 0; i < k; i++ {
        if blocks[i] == 'W' {
            currentWCount++
        }
    }

    minRecolors := currentWCount

    for i := k; i < n; i++ {
        if blocks[i-k] == 'W' {
            currentWCount--
        }
        if blocks[i] == 'W' {
            currentWCount++
        }

        if currentWCount < minRecolors {
            minRecolors = currentWCount
        }
    }

    return minRecolors
}
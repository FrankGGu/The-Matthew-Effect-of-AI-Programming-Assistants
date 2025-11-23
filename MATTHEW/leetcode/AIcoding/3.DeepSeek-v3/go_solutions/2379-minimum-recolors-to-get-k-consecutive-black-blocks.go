func minimumRecolors(blocks string, k int) int {
    minRecolors := k
    whiteCount := 0

    for i := 0; i < len(blocks); i++ {
        if blocks[i] == 'W' {
            whiteCount++
        }

        if i >= k-1 {
            if i >= k && blocks[i-k] == 'W' {
                whiteCount--
            }
            if whiteCount < minRecolors {
                minRecolors = whiteCount
            }
        }
    }

    return minRecolors
}
func shortestDistance(words []string, target string, startIndex int) int {
    n := len(words)
    minDist := -1

    for i := 0; i < n; i++ {
        currIndex := (startIndex + i) % n
        if words[currIndex] == target {
            minDist = i
            break
        }
    }

    for i := 0; i < n; i++ {
        currIndex := (startIndex - i + n) % n
        if words[currIndex] == target {
            if minDist == -1 || i < minDist {
                minDist = i
            }
            break
        }
    }

    return minDist
}
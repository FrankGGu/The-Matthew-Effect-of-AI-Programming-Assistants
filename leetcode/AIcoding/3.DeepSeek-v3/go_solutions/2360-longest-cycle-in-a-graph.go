func longestCycle(edges []int) int {
    n := len(edges)
    visited := make([]bool, n)
    maxCycle := -1

    for i := 0; i < n; i++ {
        if visited[i] {
            continue
        }
        dist := make(map[int]int)
        current := i
        distance := 0
        for current != -1 {
            if _, exists := dist[current]; exists {
                cycleLength := distance - dist[current]
                if cycleLength > maxCycle {
                    maxCycle = cycleLength
                }
                break
            }
            if visited[current] {
                break
            }
            visited[current] = true
            dist[current] = distance
            distance++
            current = edges[current]
        }
    }
    return maxCycle
}
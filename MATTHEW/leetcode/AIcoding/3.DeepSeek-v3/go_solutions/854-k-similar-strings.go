func kSimilarity(s1 string, s2 string) int {
    queue := []string{s1}
    visited := make(map[string]bool)
    visited[s1] = true
    k := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            if current == s2 {
                return k
            }
            neighbors := getNeighbors(current, s2)
            for _, neighbor := range neighbors {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    queue = append(queue, neighbor)
                }
            }
        }
        k++
    }
    return -1
}

func getNeighbors(s, target string) []string {
    var neighbors []string
    i := 0
    for i < len(s) && s[i] == target[i] {
        i++
    }
    sRunes := []rune(s)
    for j := i + 1; j < len(sRunes); j++ {
        if sRunes[j] == target[i] {
            sRunes[i], sRunes[j] = sRunes[j], sRunes[i]
            neighbors = append(neighbors, string(sRunes))
            sRunes[i], sRunes[j] = sRunes[j], sRunes[i]
        }
    }
    return neighbors
}
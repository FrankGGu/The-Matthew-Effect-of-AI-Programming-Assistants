func openLock(deadends []string, target string) int {
    dead := make(map[string]bool)
    for _, d := range deadends {
        dead[d] = true
    }
    if dead["0000"] {
        return -1
    }
    if target == "0000" {
        return 0
    }

    queue := []string{"0000"}
    visited := make(map[string]bool)
    visited["0000"] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            for j := 0; j < 4; j++ {
                for k := -1; k <= 1; k += 2 {
                    next := []byte(current)
                    next[j] = byte((int(next[j]-'0')+k+10)%10 + '0')
                    nextStr := string(next)
                    if nextStr == target {
                        return steps + 1
                    }
                    if !dead[nextStr] && !visited[nextStr] {
                        visited[nextStr] = true
                        queue = append(queue, nextStr)
                    }
                }
            }
        }
        steps++
    }
    return -1
}
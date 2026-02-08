package main

func openLock(deadends []string, target string) int {
    dead := make(map[string]bool)
    for _, d := range deadends {
        dead[d] = true
    }

    if dead["0000"] {
        return -1
    }

    queue := []string{"0000"}
    visited := make(map[string]bool)
    visited["0000"] = true

    steps := 0

    for len(queue) > 0 {
        for _, node := range queue {
            if node == target {
                return steps
            }
            for i := 0; i < 4; i++ {
                for delta := -1; delta <= 1; delta += 2 {
                    next := []byte(node)
                    next[i] = (next[i]-'0'+delta+10) % 10 + '0'
                    nextStr := string(next)
                    if !visited[nextStr] && !dead[nextStr] {
                        visited[nextStr] = true
                        queue = append(queue, nextStr)
                    }
                }
            }
        }
        queue = queue[1:]
        steps++
    }

    return -1
}
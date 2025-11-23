package main

func kSimilarStrings(s string, t string) int {
    if s == t {
        return 0
    }

    from := []rune(s)
    to := []rune(t)

    queue := [][]rune{from}
    visited := map[string]bool{string(from): true}
    steps := 0

    for len(queue) > 0 {
        for _, current := range queue {
            for i := 0; i < len(current); i++ {
                if current[i] != to[i] {
                    for j := i + 1; j < len(current); j++ {
                        if current[j] == to[i] && current[i] == to[j] {
                            current[i], current[j] = current[j], current[i]
                            key := string(current)
                            if !visited[key] {
                                if key == string(to) {
                                    return steps + 1
                                }
                                visited[key] = true
                                queue = append(queue, append([]rune{}, current...))
                            }
                            current[i], current[j] = current[j], current[i]
                        }
                    }
                }
            }
        }
        queue = queue[1:]
        steps++
    }

    return -1
}
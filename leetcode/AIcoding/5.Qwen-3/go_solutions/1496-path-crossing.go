package main

func isPathCrossing(path string) bool {
    visited := make(map[string]bool)
    visited["0,0"] = true
    x, y := 0, 0
    for _, c := range path {
        switch c {
        case 'n':
            y++
        case 's':
            y--
        case 'e':
            x++
        case 'w':
            x--
        }
        key := fmt.Sprintf("%d,%d", x, y)
        if visited[key] {
            return true
        }
        visited[key] = true
    }
    return false
}
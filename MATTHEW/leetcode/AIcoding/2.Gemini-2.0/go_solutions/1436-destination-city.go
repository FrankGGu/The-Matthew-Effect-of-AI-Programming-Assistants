func destCity(paths [][]string) string {
    starts := make(map[string]bool)
    for _, path := range paths {
        starts[path[0]] = true
    }
    for _, path := range paths {
        if _, ok := starts[path[1]]; !ok {
            return path[1]
        }
    }
    return ""
}
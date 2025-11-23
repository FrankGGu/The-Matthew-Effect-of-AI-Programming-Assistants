func destCity(paths [][]string) string {
    cityMap := make(map[string]bool)

    for _, path := range paths {
        cityMap[path[0]] = true
    }

    for _, path := range paths {
        if !cityMap[path[1]] {
            return path[1]
        }
    }

    return ""
}
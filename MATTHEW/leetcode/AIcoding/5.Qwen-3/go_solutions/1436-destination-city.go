package main

func destCity(paths [][]string) string {
    outDegree := make(map[string]int)
    for _, path := range paths {
        outDegree[path[0]]++
    }
    for _, path := range paths {
        if outDegree[path[1]] == 0 {
            return path[1]
        }
    }
    return ""
}
package main

func pathInZigzagTree(target int) []int {
    path := make([]int, 0)
    for target > 0 {
        path = append(path, target)
        target /= 2
    }
    for i, j := 0, len(path)-1; i < j; i, j = i+1, j-1 {
        path[i], path[j] = path[j], path[i]
    }
    for i := 1; i < len(path); i += 2 {
        level := 1 << (i)
        path[i] = level - 1 - (path[i] - (1 << (i-1)))
    }
    return path
}
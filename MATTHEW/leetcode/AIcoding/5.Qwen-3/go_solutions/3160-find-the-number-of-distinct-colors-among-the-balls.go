package main

func uniqueColors(balls []int) int {
    colorSet := make(map[int]bool)
    for _, ball := range balls {
        colorSet[ball] = true
    }
    return len(colorSet)
}
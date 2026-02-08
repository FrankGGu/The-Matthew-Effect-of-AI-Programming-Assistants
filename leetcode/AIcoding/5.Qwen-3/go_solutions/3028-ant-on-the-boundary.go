package main

func antOnTheBoundary(arr []int) int {
    pos := 0
    count := 0
    for _, move := range arr {
        pos += move
        if pos == 0 {
            count++
        }
    }
    return count
}
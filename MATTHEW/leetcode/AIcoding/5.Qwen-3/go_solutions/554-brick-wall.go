package main

func brickWall(wall [][]int) int {
    from := make(map[int]int)
    maxCount := 0
    for _, row := range wall {
        pos := 0
        for _, brick := range row[:len(row)-1] {
            pos += brick
            from[pos]++
            if from[pos] > maxCount {
                maxCount = from[pos]
            }
        }
    }
    return len(wall) - maxCount
}
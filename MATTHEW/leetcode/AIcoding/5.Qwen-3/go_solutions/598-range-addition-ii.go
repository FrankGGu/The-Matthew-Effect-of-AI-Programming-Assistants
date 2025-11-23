package main

func maxCount(maxX int, maxY int, ops [][]int) int {
    for _, op := range ops {
        if op[0] < maxX {
            maxX = op[0]
        }
        if op[1] < maxY {
            maxY = op[1]
        }
    }
    return maxX * maxY
}
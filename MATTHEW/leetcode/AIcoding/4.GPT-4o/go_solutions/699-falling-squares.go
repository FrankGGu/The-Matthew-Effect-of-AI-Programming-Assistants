package main

import "sort"

func fallingSquares(positions [][]int) []int {
    res := []int{}
    squares := []struct{ left, right, height int }{}
    maxHeight := 0

    for _, pos := range positions {
        left, size := pos[0], pos[1]
        right := left + size
        height := 0

        for _, square := range squares {
            if left < square.right && right > square.left {
                height = max(height, square.height)
            }
        }
        height += size
        squares = append(squares, struct{ left, right, height int }{left, right, height})
        maxHeight = max(maxHeight, height)
        res = append(res, maxHeight)
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
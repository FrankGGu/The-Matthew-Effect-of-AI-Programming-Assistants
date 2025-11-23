package main

func spiralMatrixIII(legs int) [][]int {
    result := make([][]int, 0)
    x, y := 0, 0
    dx, dy := 0, 1
    step := 1
    for legs > 0 {
        for i := 0; i < 2; i++ {
            for j := 0; j < step; j++ {
                result = append(result, []int{x, y})
                legs--
                if legs == 0 {
                    return result
                }
                x += dx
                y += dy
            }
            dx, dy = dy, -dx
        }
        step++
    }
    return result
}
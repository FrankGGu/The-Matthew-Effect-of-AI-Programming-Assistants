package main

func findSolution(customFunction func(int, int) int, z int) [][]int {
    var result [][]int
    x, y := 1, 1000
    for x <= 1000 && y >= 1 {
        val := customFunction(x, y)
        if val == z {
            result = append(result, []int{x, y})
            x++
            y--
        } else if val < z {
            x++
        } else {
            y--
        }
    }
    return result
}
func findSolution(customFunction func(int) int, z int) [][]int {
    result := [][]int{}
    for x := 1; x <= 1000; x++ {
        for y := 1; y <= 1000; y++ {
            if customFunction(x) + y == z {
                result = append(result, []int{x, y})
            }
            if customFunction(x) + y > z {
                break
            }
        }
    }
    return result
}
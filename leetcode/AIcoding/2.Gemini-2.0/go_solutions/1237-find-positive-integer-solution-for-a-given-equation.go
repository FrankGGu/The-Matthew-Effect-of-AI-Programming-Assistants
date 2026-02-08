func findSolution(customFunction func(int, int) int, z int) [][]int {
    result := [][]int{}
    for x := 1; x <= 1000; x++ {
        l, r := 1, 1000
        for l <= r {
            mid := l + (r-l)/2
            val := customFunction(x, mid)
            if val == z {
                result = append(result, []int{x, mid})
                break
            } else if val < z {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
    }
    return result
}
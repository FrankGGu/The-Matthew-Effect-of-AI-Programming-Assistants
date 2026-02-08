func minOperations(grid [][]int, x int) int {
    flat := []int{}
    for _, row := range grid {
        flat = append(flat, row...)
    }
    sort.Ints(flat)
    median := flat[len(flat)/2]
    operations := 0
    for _, num := range flat {
        diff := abs(num - median)
        if diff % x != 0 {
            return -1
        }
        operations += diff / x
    }
    return operations
}

func abs(num int) int {
    if num < 0 {
        return -num
    }
    return num
}
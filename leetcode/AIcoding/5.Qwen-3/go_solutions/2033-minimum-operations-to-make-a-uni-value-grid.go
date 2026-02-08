package main

func minOperations(grid [][]int) int {
    var values []int
    for _, row := range grid {
        for _, val := range row {
            values = append(values, val)
        }
    }

    sort.Ints(values)

    median := values[len(values)/2]
    operations := 0
    for _, val := range values {
        operations += abs(val - median)
    }
    return operations
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
func minOperations(grid [][]int, x int) int {
    nums := []int{}
    for _, row := range grid {
        for _, num := range row {
            nums = append(nums, num)
        }
    }
    sort.Ints(nums)
    median := nums[len(nums)/2]
    operations := 0
    for _, num := range nums {
        diff := abs(num - median)
        if diff%x != 0 {
            return -1
        }
        operations += diff / x
    }
    return operations
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}
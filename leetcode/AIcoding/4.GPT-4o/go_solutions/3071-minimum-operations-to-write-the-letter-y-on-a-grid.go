func minOperations(grid [][]int, x int) int {
    var nums []int
    for _, row := range grid {
        for _, value := range row {
            nums = append(nums, value)
        }
    }

    sort.Ints(nums)
    n := len(nums)
    median := nums[n/2]

    totalOps := 0
    for _, num := range nums {
        diff := abs(num - median)
        if diff % x != 0 {
            return -1
        }
        totalOps += diff / x
    }

    return totalOps
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}
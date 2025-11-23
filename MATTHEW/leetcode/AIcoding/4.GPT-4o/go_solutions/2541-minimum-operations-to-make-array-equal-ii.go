func minOperations(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    sort.Ints(nums)

    median := nums[n/2]
    ops := 0

    for _, num := range nums {
        ops += abs(num - median)
    }

    return ops
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
func findNonMinOrMax(nums []int) int {
    if len(nums) <= 2 {
        return -1
    }
    min, max := nums[0], nums[0]
    for _, num := range nums {
        if num < min {
            min = num
        }
        if num > max {
            max = num
        }
    }
    for _, num := range nums {
        if num != min && num != max {
            return num
        }
    }
    return -1
}
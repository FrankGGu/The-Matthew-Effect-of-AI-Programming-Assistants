func findDisappearedNumbers(nums []int) []int {
    n := len(nums)
    for i := 0; i < n; i++ {
        index := abs(nums[i]) - 1
        if nums[index] > 0 {
            nums[index] = -nums[index]
        }
    }
    result := []int{}
    for i := 0; i < n; i++ {
        if nums[i] > 0 {
            result = append(result, i+1)
        }
    }
    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
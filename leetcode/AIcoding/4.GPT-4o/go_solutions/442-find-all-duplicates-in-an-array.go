func findDuplicates(nums []int) []int {
    result := []int{}
    for i := 0; i < len(nums); i++ {
        index := abs(nums[i]) - 1
        if nums[index] < 0 {
            result = append(result, index+1)
        }
        nums[index] = -nums[index]
    }
    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
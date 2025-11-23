func findDuplicates(nums []int) []int {
    res := []int{}
    for i := 0; i < len(nums); i++ {
        idx := abs(nums[i]) - 1
        if nums[idx] < 0 {
            res = append(res, idx+1)
        } else {
            nums[idx] = -nums[idx]
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
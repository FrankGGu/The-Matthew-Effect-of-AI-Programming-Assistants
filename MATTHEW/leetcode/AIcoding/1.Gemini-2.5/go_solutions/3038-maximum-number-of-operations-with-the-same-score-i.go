func maxOperations(nums []int) int {
    if len(nums) < 2 {
        return 0
    }

    targetScore := nums[0] + nums[1]
    operations := 1

    for i := 2; i < len(nums); i += 2 {
        if nums[i]+nums[i+1] == targetScore {
            operations++
        } else {
            break
        }
    }

    return operations
}
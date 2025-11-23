func maxOperations(nums []int) int {
    if len(nums) < 2 {
        return 0
    }
    score := nums[0] + nums[1]
    count := 1
    for i := 2; i < len(nums)-1; i += 2 {
        if nums[i]+nums[i+1] == score {
            count++
        } else {
            break
        }
    }
    return count
}
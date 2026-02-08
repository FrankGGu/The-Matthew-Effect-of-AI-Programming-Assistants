func findScore(nums []int) int64 {
    n := len(nums)
    marked := make([]bool, n)
    score := int64(0)

    for i := 0; i < n; i++ {
        if marked[i] {
            continue
        }
        score += int64(nums[i])
        if i+1 < n && nums[i] == nums[i+1] {
            marked[i] = true
            marked[i+1] = true
        } else if i+1 < n && nums[i] > nums[i+1] {
            marked[i] = true
        } else if i > 0 && nums[i] > nums[i-1] {
            marked[i] = true
        }
    }

    return score
}
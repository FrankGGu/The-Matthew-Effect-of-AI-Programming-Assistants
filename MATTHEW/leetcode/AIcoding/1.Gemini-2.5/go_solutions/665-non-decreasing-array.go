func checkPossibility(nums []int) bool {
    count := 0
    n := len(nums)

    for i := 0; i < n-1; i++ {
        if nums[i] > nums[i+1] {
            count++
            if count > 1 {
                return false
            }

            if i == 0 || nums[i+1] >= nums[i-1] {
                nums[i] = nums[i+1]
            } else {
                nums[i+1] = nums[i]
            }
        }
    }

    return true
}
func incremovableSubarrayCount(nums []int) int {
    n := len(nums)
    count := 0

    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            valid := true
            prev := -1
            for k := 0; k < n; k++ {
                if k >= i && k <= j {
                    continue
                }
                if nums[k] <= prev {
                    valid = false
                    break
                }
                prev = nums[k]
            }
            if valid {
                count++
            }
        }
    }

    return count
}
func minimumReplacement(nums []int) int {
    n := len(nums)
    count := 0
    maxVal := nums[n-1]

    for i := n - 2; i >= 0; i-- {
        if nums[i] > maxVal {
            k := (nums[i] + maxVal - 1) / maxVal
            count += k - 1
            maxVal = nums[i] / k
        } else {
            maxVal = nums[i]
        }
    }

    return count
}
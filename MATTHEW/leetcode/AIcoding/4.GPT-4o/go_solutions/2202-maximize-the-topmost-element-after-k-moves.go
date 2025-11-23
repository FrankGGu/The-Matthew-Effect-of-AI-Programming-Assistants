func maximumTop(nums []int, k int) int {
    n := len(nums)
    if k == 0 {
        if n > 0 {
            return nums[0]
        }
        return 0
    }
    if k >= n {
        maxVal := 0
        for _, num := range nums {
            if num > maxVal {
                maxVal = num
            }
        }
        return maxVal
    }

    maxVal := 0
    for i := 0; i < k-1 && i < n; i++ {
        if nums[i] > maxVal {
            maxVal = nums[i]
        }
    }
    if k < n {
        if nums[k] > maxVal {
            maxVal = nums[k]
        }
    }
    return maxVal
}
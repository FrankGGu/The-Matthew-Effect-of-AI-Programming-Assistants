func findUnsortedSubarray(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    left, right := 0, n-1
    for left < n-1 && nums[left] <= nums[left+1] {
        left++
    }
    if left == n-1 {
        return 0
    }

    for right > 0 && nums[right] >= nums[right-1] {
        right--
    }

    minVal, maxVal := math.MaxInt32, math.MinInt32
    for i := left; i <= right; i++ {
        if nums[i] < minVal {
            minVal = nums[i]
        }
        if nums[i] > maxVal {
            maxVal = nums[i]
        }
    }

    for left > 0 && nums[left-1] > minVal {
        left--
    }
    for right < n-1 && nums[right+1] < maxVal {
        right++
    }

    return right - left + 1
}
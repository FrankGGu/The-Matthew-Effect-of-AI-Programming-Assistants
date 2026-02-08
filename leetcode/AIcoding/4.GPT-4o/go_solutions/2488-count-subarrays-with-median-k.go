func countSubarrays(nums []int, k int) int {
    left := 0
    right := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        if nums[i] < k {
            left++
        } else if nums[i] > k {
            right++
        }
    }

    if left > right {
        return 0
    }

    count := 0
    leftCount := 0
    rightCount := 0
    for i := 0; i < n; i++ {
        if nums[i] < k {
            leftCount++
        } else if nums[i] > k {
            rightCount++
        } else {
            count += (leftCount + 1) * (rightCount + 1)
            leftCount = 0
            rightCount = 0
        }
    }
    count += (leftCount + 1) * (rightCount + 1)

    return count
}
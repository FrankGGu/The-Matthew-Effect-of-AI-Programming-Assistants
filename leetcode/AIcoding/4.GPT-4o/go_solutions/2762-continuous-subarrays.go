func continuousSubarrays(nums []int) int {
    left, right := 0, 0
    count := 0
    maxNum, minNum := nums[0], nums[0]

    for right < len(nums) {
        maxNum = max(maxNum, nums[right])
        minNum = min(minNum, nums[right])

        if maxNum-minNum > 2 {
            left++
            right = left
            maxNum, minNum = nums[left], nums[left]
        } else {
            count += right - left + 1
            right++
        }
    }

    return count
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
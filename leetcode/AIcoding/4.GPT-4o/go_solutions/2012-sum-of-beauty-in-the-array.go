func sumOfBeauty(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    leftMax := make([]int, n)
    rightMin := make([]int, n)

    leftMax[0] = nums[0]
    for i := 1; i < n; i++ {
        leftMax[i] = max(leftMax[i-1], nums[i])
    }

    rightMin[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        rightMin[i] = min(rightMin[i+1], nums[i])
    }

    beautySum := 0
    for i := 1; i < n-1; i++ {
        if nums[i] > leftMax[i-1] && nums[i] < rightMin[i+1] {
            beautySum += 2
        } else if nums[i] < leftMax[i-1] && nums[i] > rightMin[i+1] {
            beautySum += 2
        } else if nums[i] > leftMax[i-1] || nums[i] < rightMin[i+1] {
            beautySum += 1
        }
    }

    return beautySum
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
package main

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func sumOfBeauty(nums []int) int {
    n := len(nums)
    leftMin := make([]int, n)
    rightMax := make([]int, n)

    leftMin[0] = nums[0]
    for i := 1; i < n; i++ {
        leftMin[i] = min(leftMin[i-1], nums[i])
    }

    rightMax[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        rightMax[i] = max(rightMax[i+1], nums[i])
    }

    result := 0
    for i := 1; i < n-1; i++ {
        if nums[i] > leftMin[i-1] && nums[i] < rightMax[i+1] {
            result += 2
        } else if nums[i] > leftMin[i-1] || nums[i] < rightMax[i+1] {
            result += 1
        }
    }

    return result
}
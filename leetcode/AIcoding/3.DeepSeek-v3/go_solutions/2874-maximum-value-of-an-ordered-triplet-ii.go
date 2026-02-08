func maximumTripletValue(nums []int) int64 {
    n := len(nums)
    if n < 3 {
        return 0
    }

    maxDiff := 0
    maxRight := make([]int, n)
    maxRight[n-1] = nums[n-1]

    for i := n-2; i >= 0; i-- {
        maxRight[i] = max(nums[i], maxRight[i+1])
    }

    maxLeft := nums[0]
    res := 0

    for j := 1; j < n-1; j++ {
        currentDiff := maxLeft - nums[j]
        if currentDiff > maxDiff {
            maxDiff = currentDiff
        }
        if nums[j] > maxLeft {
            maxLeft = nums[j]
        }
        current := maxDiff * maxRight[j+1]
        if current > res {
            res = current
        }
    }

    return int64(res)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
func minSubArray(nums []int) int {
    minSum := math.MaxInt32
    currentSum := 0
    for _, num := range nums {
        currentSum += num
        if currentSum < minSum {
            minSum = currentSum
        }
        if currentSum > 0 {
            currentSum = 0
        }
    }
    if minSum > 0 {
        return 0
    }
    return minSum
}

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

func minPositiveSumSubarray(nums []int) int {
    minPosSum := math.MaxInt32
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 1; i <= n; i++ {
        prefix[i] = prefix[i-1] + nums[i-1]
    }

    for i := 1; i <= n; i++ {
        for j := 0; j < i; j++ {
            sum := prefix[i] - prefix[j]
            if sum > 0 {
                minPosSum = min(minPosSum, sum)
            }
        }
    }

    if minPosSum == math.MaxInt32 {
        return -1
    }
    return minPosSum
}
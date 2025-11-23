package main

func minimumAverageDifference(nums []int) int {
    n := len(nums)
    total := 0
    for _, num := range nums {
        total += num
    }

    leftSum := 0
    minDiff := float64(1<<31 - 1)
    resultIndex := 0

    for i := 0; i < n; i++ {
        leftSum += nums[i]
        rightSum := total - leftSum

        leftAvg := float64(leftSum) / float64(i+1)
        rightAvg := float64(rightSum) / float64(n-i-1)

        diff := abs(leftAvg - rightAvg)
        if diff < minDiff {
            minDiff = diff
            resultIndex = i
        }
    }

    return resultIndex
}

func abs(x float64) float64 {
    if x < 0 {
        return -x
    }
    return x
}
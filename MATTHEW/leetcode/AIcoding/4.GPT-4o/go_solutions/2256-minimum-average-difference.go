func minimumAverageDifference(nums []int) int {
    n := len(nums)
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    minDiff := math.MaxInt64
    minIndex := 0
    leftSum := 0

    for i := 0; i < n; i++ {
        leftSum += nums[i]
        rightSum := totalSum - leftSum

        leftAvg := leftSum / (i + 1)
        var rightAvg int
        if i < n-1 {
            rightAvg = rightSum / (n - i - 1)
        } else {
            rightAvg = 0
        }

        diff := int(math.Abs(float64(leftAvg - rightAvg)))
        if diff < minDiff {
            minDiff = diff
            minIndex = i
        }
    }

    return minIndex
}
func minimumAverageDifference(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    prefixSum := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + int64(nums[i])
    }

    minDiff := int64(1<<63 - 1)
    result := 0

    for i := 0; i < n; i++ {
        leftSum := prefixSum[i+1]
        leftAvg := leftSum / int64(i+1)

        rightSum := prefixSum[n] - prefixSum[i+1]
        var rightAvg int64
        if n - i - 1 != 0 {
            rightAvg = rightSum / int64(n - i - 1)
        } else {
            rightAvg = 0
        }

        diff := abs(leftAvg - rightAvg)
        if diff < minDiff {
            minDiff = diff
            result = i
        } else if diff == minDiff && i < result {
            result = i
        }
    }

    return result
}

func abs(a int64) int64 {
    if a < 0 {
        return -a
    }
    return a
}
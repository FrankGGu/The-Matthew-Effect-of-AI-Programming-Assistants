func maxManhattanDistance(nums1 []int, nums2 []int, k int) int {
    n := len(nums1)
    if n == 0 {
        return 0
    }

    maxSum := math.MinInt32
    minSum := math.MaxInt32
    maxDiff := math.MinInt32
    minDiff := math.MaxInt32

    for i := 0; i < n; i++ {
        sum := nums1[i] + nums2[i]
        diff := nums1[i] - nums2[i]

        if sum > maxSum {
            maxSum = sum
        }
        if sum < minSum {
            minSum = sum
        }
        if diff > maxDiff {
            maxDiff = diff
        }
        if diff < minDiff {
            minDiff = diff
        }
    }

    candidate1 := maxSum - minSum
    candidate2 := maxDiff - minDiff

    if candidate1 > candidate2 {
        return candidate1
    }
    return candidate2
}
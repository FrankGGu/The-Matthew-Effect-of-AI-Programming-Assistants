func maximumsSplicedArray(nums1 []int, nums2 []int) int {
    n := len(nums1)
    sum1, sum2 := 0, 0
    for i := 0; i < n; i++ {
        sum1 += nums1[i]
        sum2 += nums2[i]
    }

    maxDiff1, maxDiff2 := 0, 0
    current1, current2 := 0, 0
    for i := 0; i < n; i++ {
        diff := nums2[i] - nums1[i]
        current1 = max(diff, current1 + diff)
        maxDiff1 = max(maxDiff1, current1)

        diff = nums1[i] - nums2[i]
        current2 = max(diff, current2 + diff)
        maxDiff2 = max(maxDiff2, current2)
    }

    return max(sum1 + maxDiff1, sum2 + maxDiff2)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
package main

func maxSubarraySum(nums1 []int, nums2 []int) int {
    maxSum := func(a, b []int) int {
        maxEndingHere := 0
        maxSoFar := math.MinInt64
        for i := 0; i < len(a); i++ {
            maxEndingHere = max(maxEndingHere+a[i]-b[i], a[i]-b[i])
            maxSoFar = max(maxSoFar, maxEndingHere)
        }
        return maxSoFar
    }

    max1 := maxSubarraySumHelper(nums1, nums2)
    max2 := maxSubarraySumHelper(nums2, nums1)
    return max(max1, max2)
}

func maxSubarraySumHelper(a, b []int) int {
    maxEndingHere := 0
    maxSoFar := math.MinInt64
    for i := 0; i < len(a); i++ {
        maxEndingHere = max(maxEndingHere+a[i]-b[i], a[i]-b[i])
        maxSoFar = max(maxSoFar, maxEndingHere)
    }
    return maxSoFar
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
func maxNonDecreasingLength(nums1 []int, nums2 []int) int {
    n := len(nums1)
    if n == 0 {
        return 0
    }
    dp1, dp2 := 1, 1
    res := 1
    for i := 1; i < n; i++ {
        newDp1, newDp2 := 1, 1
        if nums1[i] >= nums1[i-1] {
            newDp1 = max(newDp1, dp1+1)
        }
        if nums1[i] >= nums2[i-1] {
            newDp1 = max(newDp1, dp2+1)
        }
        if nums2[i] >= nums1[i-1] {
            newDp2 = max(newDp2, dp1+1)
        }
        if nums2[i] >= nums2[i-1] {
            newDp2 = max(newDp2, dp2+1)
        }
        dp1, dp2 = newDp1, newDp2
        res = max(res, max(dp1, dp2))
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
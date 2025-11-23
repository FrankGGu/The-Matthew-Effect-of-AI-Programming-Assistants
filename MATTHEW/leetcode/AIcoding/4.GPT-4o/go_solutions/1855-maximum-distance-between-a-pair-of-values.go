func maxDistance(nums1 []int, nums2 []int) int {
    maxDist := 0
    j := len(nums2) - 1

    for i := 0; i < len(nums1); i++ {
        for j >= 0 && nums2[j] < nums1[i] {
            j--
        }
        if j >= 0 {
            maxDist = max(maxDist, j-i)
        }
    }

    return maxDist
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
func maxDistance(nums1 []int, nums2 []int) int {
    n1 := len(nums1)
    n2 := len(nums2)

    maxDist := 0
    i := 0 // pointer for nums1
    j := 0 // pointer for nums2

    for i < n1 && j < n2 {
        if nums1[i] <= nums2[j] {
            maxDist = max(maxDist, j - i)
            j++
        } else {
            i++
            if i > j {
                j = i
            }
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
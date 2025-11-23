func findMedianSortedArrays(nums1 []int, nums2 []int) float64 {
    n1, n2 := len(nums1), len(nums2)
    if n1 > n2 {
        nums1, nums2 = nums2, nums1
        n1, n2 = n2, n1
    }

    imin, imax, halfLen := 0, n1, (n1+n2+1)/2
    for imin <= imax {
        i := (imin + imax) / 2
        j := halfLen - i
        if i < n1 && nums2[j-1] > nums1[i] {
            imin = i + 1
        } else if i > 0 && nums1[i-1] > nums2[j] {
            imax = i - 1
        } else {
            var maxOfLeft, minOfRight float64
            if i == 0 {
                maxOfLeft = float64(nums2[j-1])
            } else if j == 0 {
                maxOfLeft = float64(nums1[i-1])
            } else {
                maxOfLeft = float64(max(nums1[i-1], nums2[j-1]))
            }
            if (n1+n2)%2 == 1 {
                return maxOfLeft
            }
            if i == n1 {
                minOfRight = float64(nums2[j])
            } else if j == n2 {
                minOfRight = float64(nums1[i])
            } else {
                minOfRight = float64(min(nums1[i], nums2[j]))
            }
            return (maxOfLeft + minOfRight) / 2
        }
    }
    return 0.0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
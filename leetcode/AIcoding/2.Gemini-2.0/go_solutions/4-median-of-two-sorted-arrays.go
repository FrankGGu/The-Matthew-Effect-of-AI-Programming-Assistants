func findMedianSortedArrays(nums1 []int, nums2 []int) float64 {
    m, n := len(nums1), len(nums2)
    if m > n {
        nums1, nums2 = nums2, nums1
        m, n = n, m
    }
    iMin, iMax := 0, m
    for iMin <= iMax {
        i := (iMin + iMax) / 2
        j := (m+n+1)/2 - i
        if i < m && nums2[j-1] > nums1[i] {
            iMin = i + 1
        } else if i > 0 && nums1[i-1] > nums2[j] {
            iMax = i - 1
        } else {
            maxLeft := 0
            if i == 0 {
                maxLeft = nums2[j-1]
            } else if j == 0 {
                maxLeft = nums1[i-1]
            } else {
                maxLeft = max(nums1[i-1], nums2[j-1])
            }
            if (m+n)%2 == 1 {
                return float64(maxLeft)
            }

            minRight := 0
            if i == m {
                minRight = nums2[j]
            } else if j == n {
                minRight = nums1[i]
            } else {
                minRight = min(nums1[i], nums2[j])
            }

            return float64(maxLeft+minRight) / 2.0
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
func maxSum(nums1 []int, nums2 []int) int {
    mod := int(1e9 + 7)
    i, j := 0, 0
    n, m := len(nums1), len(nums2)
    sum1, sum2 := 0, 0
    res := 0

    for i < n && j < m {
        if nums1[i] < nums2[j] {
            sum1 += nums1[i]
            i++
        } else if nums1[i] > nums2[j] {
            sum2 += nums2[j]
            j++
        } else {
            res += max(sum1, sum2) + nums1[i]
            sum1, sum2 = 0, 0
            i++
            j++
        }
    }

    for i < n {
        sum1 += nums1[i]
        i++
    }

    for j < m {
        sum2 += nums2[j]
        j++
    }

    res = (res + max(sum1, sum2)) % mod
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
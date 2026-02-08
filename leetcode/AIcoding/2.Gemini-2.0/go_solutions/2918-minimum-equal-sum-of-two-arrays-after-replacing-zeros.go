func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}

func minSum(nums1 []int, nums2 []int) int64 {
    var sum1, sum2 int64
    var zeros1, zeros2 int
    for _, num := range nums1 {
        sum1 += int64(num)
        if num == 0 {
            zeros1++
        }
    }
    for _, num := range nums2 {
        sum2 += int64(num)
        if num == 0 {
            zeros2++
        }
    }

    if sum1+int64(zeros1) < sum2 && zeros2 == 0 {
        return -1
    }

    if sum2+int64(zeros2) < sum1 && zeros1 == 0 {
        return -1
    }

    return max(sum1+int64(zeros1), sum2+int64(zeros2))
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}
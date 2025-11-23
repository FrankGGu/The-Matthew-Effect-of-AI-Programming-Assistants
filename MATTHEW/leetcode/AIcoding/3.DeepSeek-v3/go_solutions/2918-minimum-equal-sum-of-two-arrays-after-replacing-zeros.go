func minSum(nums1 []int, nums2 []int) int64 {
    sum1, zero1 := 0, 0
    for _, num := range nums1 {
        if num == 0 {
            zero1++
        } else {
            sum1 += num
        }
    }

    sum2, zero2 := 0, 0
    for _, num := range nums2 {
        if num == 0 {
            zero2++
        } else {
            sum2 += num
        }
    }

    if zero1 == 0 && zero2 == 0 {
        if sum1 == sum2 {
            return int64(sum1)
        } else {
            return -1
        }
    }

    if zero1 == 0 {
        if sum1 < sum2 + zero2 {
            return -1
        }
    }

    if zero2 == 0 {
        if sum2 < sum1 + zero1 {
            return -1
        }
    }

    return int64(max(sum1 + zero1, sum2 + zero2))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
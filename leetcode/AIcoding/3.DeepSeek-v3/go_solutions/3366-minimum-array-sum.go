func minSum(nums1 []int, nums2 []int) int64 {
    sum1, sum2 := 0, 0
    zero1, zero2 := false, false

    for _, num := range nums1 {
        if num == 0 {
            zero1 = true
            sum1 += 1
        } else {
            sum1 += num
        }
    }

    for _, num := range nums2 {
        if num == 0 {
            zero2 = true
            sum2 += 1
        } else {
            sum2 += num
        }
    }

    if !zero1 && sum1 < sum2 {
        return -1
    }
    if !zero2 && sum2 < sum1 {
        return -1
    }

    if sum1 > sum2 {
        return int64(sum1)
    }
    return int64(sum2)
}
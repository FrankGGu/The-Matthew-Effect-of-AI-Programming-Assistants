func minOperations(nums1 []int, nums2 []int, k int) int64 {
    if k == 0 {
        for i := 0; i < len(nums1); i++ {
            if nums1[i] != nums2[i] {
                return -1
            }
        }
        return 0
    }

    var posSum, negSum int64
    for i := 0; i < len(nums1); i++ {
        diff := nums1[i] - nums2[i]
        if diff%k != 0 {
            return -1
        }
        if diff > 0 {
            posSum += int64(diff / k)
        } else if diff < 0 {
            negSum += int64(-diff / k)
        }
    }

    if posSum != negSum {
        return -1
    }

    return posSum
}
func minOperations(nums1 []int, nums2 []int, k int) int64 {
    n := len(nums1)
    var pos, neg int64
    for i := 0; i < n; i++ {
        diff := nums1[i] - nums2[i]
        if k == 0 {
            if diff != 0 {
                return -1
            }
            continue
        }
        if diff % k != 0 {
            return -1
        }
        ops := diff / k
        if ops > 0 {
            pos += int64(ops)
        } else {
            neg += int64(-ops)
        }
    }
    if pos != neg {
        return -1
    }
    return pos
}
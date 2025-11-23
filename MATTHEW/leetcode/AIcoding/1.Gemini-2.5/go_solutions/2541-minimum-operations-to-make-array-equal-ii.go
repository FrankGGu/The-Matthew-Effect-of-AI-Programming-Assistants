func minOperations(nums1 []int, nums2 []int, k int) int64 {
    n := len(nums1)

    if k == 0 {
        for i := 0; i < n; i++ {
            if nums1[i] != nums2[i] {
                return -1
            }
        }
        return 0
    }

    var totalDiffSum int64 = 0
    var positiveDiffSum int64 = 0

    for i := 0; i < n; i++ {
        diff := nums1[i] - nums2[i]

        if diff % k != 0 {
            return -1
        }

        totalDiffSum += int64(diff)
        if diff > 0 {
            positiveDiffSum += int64(diff)
        }
    }

    if totalDiffSum != 0 {
        return -1
    }

    return positiveDiffSum / int64(k)
}
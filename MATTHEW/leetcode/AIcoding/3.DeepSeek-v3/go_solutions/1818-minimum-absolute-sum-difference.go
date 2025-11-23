func minAbsoluteSumDiff(nums1 []int, nums2 []int) int {
    mod := int(1e9 + 7)
    n := len(nums1)
    sorted := make([]int, n)
    copy(sorted, nums1)
    sort.Ints(sorted)

    total := 0
    maxGain := 0
    for i := 0; i < n; i++ {
        diff := abs(nums1[i] - nums2[i])
        total = (total + diff) % mod

        j := sort.SearchInts(sorted, nums2[i])
        if j < n {
            gain := diff - (sorted[j] - nums2[i])
            if gain > maxGain {
                maxGain = gain
            }
        }
        if j > 0 {
            gain := diff - (nums2[i] - sorted[j-1])
            if gain > maxGain {
                maxGain = gain
            }
        }
    }

    return (total - maxGain + mod) % mod
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
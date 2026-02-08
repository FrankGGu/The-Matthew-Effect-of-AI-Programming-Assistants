func minAbsoluteSumDiff(nums1 []int, nums2 []int) int {
    const mod = 1_000_000_007
    n := len(nums1)
    totalDiff := 0
    maxImprovement := 0

    sortedNums1 := make([]int, n)
    copy(sortedNums1, nums1)
    sort.Ints(sortedNums1)

    for i := 0; i < n; i++ {
        diff := abs(nums1[i] - nums2[i])
        totalDiff = (totalDiff + diff) % mod

        idx := sort.SearchInts(sortedNums1, nums2[i])
        if idx < n {
            improvement := diff - abs(sortedNums1[idx] - nums2[i])
            if improvement > maxImprovement {
                maxImprovement = improvement
            }
        }
        if idx > 0 {
            improvement := diff - abs(sortedNums1[idx-1] - nums2[i])
            if improvement > maxImprovement {
                maxImprovement = improvement
            }
        }
    }

    return (totalDiff - maxImprovement + mod) % mod
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
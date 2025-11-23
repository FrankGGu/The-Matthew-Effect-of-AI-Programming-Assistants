func maximumSetSize(nums1 []int, nums2 []int) int {
    set1 := make(map[int]bool)
    set2 := make(map[int]bool)
    common := make(map[int]bool)

    for _, num := range nums1 {
        set1[num] = true
    }
    for _, num := range nums2 {
        set2[num] = true
    }

    for num := range set1 {
        if set2[num] {
            common[num] = true
        }
    }

    n := len(nums1)
    maxUnique1 := min(len(set1)-len(common), n/2)
    maxUnique2 := min(len(set2)-len(common), n/2)
    remaining := n - maxUnique1 - maxUnique2

    if remaining > 0 {
        commonSize := min(len(common), remaining)
        return maxUnique1 + maxUnique2 + commonSize
    }
    return maxUnique1 + maxUnique2
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
func minOperations(nums1 []int, nums2 []int) int {
    if len(nums1) > len(nums2) {
        nums1, nums2 = nums2, nums1
    }

    set := make(map[int]struct{})
    for _, num := range nums1 {
        set[num] = struct{}{}
    }

    common := 0
    for _, num := range nums2 {
        if _, exists := set[num]; exists {
            common++
        }
    }

    n1, n2 := len(nums1), len(nums2)
    need := n1 - common
    if need <= 0 {
        return 0
    }

    ops := 0
    for i := 1; i <= 6; i++ {
        if _, exists := set[i]; !exists {
            ops++
        }
    }

    if ops < need {
        return need - ops
    }

    return need
}
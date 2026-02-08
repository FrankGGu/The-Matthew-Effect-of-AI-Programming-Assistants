func minSwap(nums1 []int, nums2 []int) int {
    n := len(nums1)
    swap, notSwap := 1, 0
    for i := 1; i < n; i++ {
        newSwap, newNotSwap := n, n
        if nums1[i] > nums1[i-1] && nums2[i] > nums2[i-1] {
            newNotSwap = min(newNotSwap, notSwap)
            newSwap = min(newSwap, swap+1)
        }
        if nums1[i] > nums2[i-1] && nums2[i] > nums1[i-1] {
            newNotSwap = min(newNotSwap, swap)
            newSwap = min(newSwap, notSwap+1)
        }
        swap, notSwap = newSwap, newNotSwap
    }
    return min(swap, notSwap)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
import "math"

func minSwap(nums1 []int, nums2 []int) int {
    n := len(nums1)

    // keep: minimum swaps to make sequences increasing up to current index i,
    //       with nums1[i] and nums2[i] NOT swapped.
    // swap: minimum swaps to make sequences increasing up to current index i,
    //       with nums1[i] and nums2[i] SWAPPED.

    // Base case for i = 0
    keep := 0 // 0 swaps to keep the first pair as is
    swap := 1 // 1 swap to swap the first pair

    for i := 1; i < n; i++ {
        newKeep := math.MaxInt32
        newSwap := math.MaxInt32

        // Option 1: Do not swap nums1[i] and nums2[i]
        // Check if (nums1[i], nums2[i]) can follow (nums1[i-1], nums2[i-1]) (previous was kept)
        if nums1[i] > nums1[i-1] && nums2[i] > nums2[i-1] {
            newKeep = min(newKeep, keep)
        }
        // Check if (nums1[i], nums2[i]) can follow (nums2[i-1], nums1[i-1]) (previous was swapped)
        if nums1[i] > nums2[i-1] && nums2[i] > nums1[i-1] {
            newKeep = min(newKeep, swap)
        }

        // Option 2: Swap nums1[i] and nums2[i]
        // Check if (nums2[i], nums1[i]) can follow (nums1[i-1], nums2[i-1]) (previous was kept)
        if nums2[i] > nums1[i-1] && nums1[i] > nums2[i-1] {
            newSwap = min(newSwap, keep+1)
        }
        // Check if (nums2[i], nums1[i]) can follow (nums2[i-1], nums1[i-1]) (previous was swapped)
        if nums2[i] > nums2[i-1] && nums1[i] > nums1[i-1] {
            newSwap = min(newSwap, swap+1)
        }

        keep = newKeep
        swap = newSwap
    }

    return min(keep, swap)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
import "math"

func findMedianSortedArrays(nums1 []int, nums2 []int) float64 {
    // Ensure nums1 is the shorter array to simplify binary search range
    if len(nums1) > len(nums2) {
        nums1, nums2 = nums2, nums1
    }

    m :=
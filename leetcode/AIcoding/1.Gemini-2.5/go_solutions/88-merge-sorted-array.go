func merge(nums1 []int, m int, nums2 []int, n int) {
    p1 := m - 1       // Pointer for the last element of nums1's actual data
    p2 := n - 1       // Pointer for the last element of nums2
    p := m + n - 1    // Pointer
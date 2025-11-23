package main

func minOperations(nums1 []int, nums2 []int) int {
    n := len(nums1)
    m := len(nums2)

    if n == 0 || m == 0 {
        return 0
    }

    res := 0

    for i := n - 1; i >= 0; i-- {
        if nums1[i] > nums2[i] {
            nums1[i], nums2[i] = nums2[i], nums1[i]
            res++
        }
    }

    for i := m - 1; i >= 0; i-- {
        if nums2[i] > nums1[i] {
            nums2[i], nums1[i] = nums1[i], nums2[i]
            res++
        }
    }

    return res
}
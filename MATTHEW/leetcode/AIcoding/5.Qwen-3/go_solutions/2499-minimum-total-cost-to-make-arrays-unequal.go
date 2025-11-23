package main

func minTotalCostToMakeArraysUnequal(nums1 []int, nums2 []int) int {
    n := len(nums1)
    m := len(nums2)
    if n == 0 || m == 0 {
        return 0
    }
    cost := 0
    for i := 0; i < n && i < m; i++ {
        if nums1[i] == nums2[i] {
            cost += nums1[i]
        }
    }
    return cost
}
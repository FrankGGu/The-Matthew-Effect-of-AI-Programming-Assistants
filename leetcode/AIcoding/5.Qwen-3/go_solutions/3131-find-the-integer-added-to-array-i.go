package main

func addedInteger(nums1 []int, nums2 []int) int {
    for i := 0; i < len(nums1); i++ {
        nums1[i] = nums2[i] - nums1[i]
    }
    return nums1[0]
}
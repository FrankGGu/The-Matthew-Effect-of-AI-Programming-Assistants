package main

func numberOfPairs(nums1 []int, nums2 []int) int {
    n := len(nums1)
    res := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if nums1[i]-nums2[i] > nums1[j]-nums2[j] {
                res++
            }
        }
    }
    return res
}
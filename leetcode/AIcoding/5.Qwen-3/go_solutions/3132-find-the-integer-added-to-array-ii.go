package main

func addedInteger(nums1 []int, nums2 []int) int {
    diff := make(map[int]int)
    for i := 0; i < len(nums1); i++ {
        diff[nums2[i]-nums1[i]]++
    }
    for k, v := range diff {
        if v == len(nums1) {
            return k
        }
    }
    return 0
}
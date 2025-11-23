package main

func numTriplets(nums1 []int, nums2 []int) int {
    totalWays := 0

    // Type 1: nums1[i]^2 == nums2[j] * nums2[k]
    prodMap2 := make(map[int64]int)
    for j := 0; j < len(nums2); j++ {
        for k := j + 1; k < len(nums2); k++ {
            prod := int64(nums2[j]) * int64(nums2[k])
            prodMap2[prod]++
        }
    }
    for i := 0; i < len(nums1); i++ {
        square := int64(nums1[i]) * int64(nums1[i])
        totalWays += prodMap2[square]
    }

    // Type 2: nums2[i]^2 == nums1[j] * nums1[k]
    prodMap1 := make(map[int64]int)
    for j := 0; j < len(nums1); j++ {
        for k := j + 1; k < len(nums1); k++ {
            prod := int64(nums1[j]) * int64(nums1[k])
            prodMap1[prod]++
        }
    }
    for i := 0; i < len(nums2); i++ {
        square := int64(nums2[i]) * int64(nums2[i])
        totalWays += prodMap1[square]
    }

    return totalWays
}
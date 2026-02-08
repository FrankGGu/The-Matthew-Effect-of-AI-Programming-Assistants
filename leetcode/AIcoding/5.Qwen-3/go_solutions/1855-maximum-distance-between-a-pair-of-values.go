package main

func maxDistance(nums1 []int, nums2 []int) int {
    maxDist := 0
    i := 0
    j := 0
    for i < len(nums1) && j < len(nums2) {
        if nums1[i] <= nums2[j] {
            if i < j {
                maxDist = max(maxDist, j-i)
            }
            j++
        } else {
            i++
        }
    }
    return maxDist
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
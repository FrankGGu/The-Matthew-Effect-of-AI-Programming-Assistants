package main

func xorAllElements(nums1 []int, nums2 []int) int {
    result := 0
    for _, num := range nums1 {
        result ^= num
    }
    for _, num := range nums2 {
        result ^= num
    }
    return result
}
package main

func fourSumCount(nums1 []int, nums2 []int, nums3 []int, nums4 []int) int {
    count := make(map[int]int)
    for _, a := range nums1 {
        for _, b := range nums2 {
            count[a+b]++
        }
    }
    result := 0
    for _, c := range nums3 {
        for _, d := range nums4 {
            result += count[-(c+d)]
        }
    }
    return result
}
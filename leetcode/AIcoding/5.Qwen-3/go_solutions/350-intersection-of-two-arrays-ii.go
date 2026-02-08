package main

func intersect(nums1 []int, nums2 []int) []int {
    if len(nums1) > len(nums2) {
        return intersect(nums2, nums1)
    }

    count := make(map[int]int)
    for _, num := range nums1 {
        count[num]++
    }

    result := make([]int, 0)
    for _, num := range nums2 {
        if count[num] > 0 {
            result = append(result, num)
            count[num]--
        }
    }

    return result
}
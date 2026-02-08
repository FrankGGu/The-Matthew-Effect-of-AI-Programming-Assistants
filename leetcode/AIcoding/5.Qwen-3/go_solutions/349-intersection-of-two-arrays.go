package main

func intersection(nums1 []int, nums2 []int) []int {
    set := make(map[int]bool)
    result := []int{}

    for _, num := range nums1 {
        set[num] = true
    }

    for _, num := range nums2 {
        if set[num] {
            result = append(result, num)
            set[num] = false
        }
    }

    return result
}
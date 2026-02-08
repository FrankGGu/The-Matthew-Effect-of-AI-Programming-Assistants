package main

func minNumber(nums1 []int, nums2 []int) int {
    set1 := make(map[int]bool)
    set2 := make(map[int]bool)
    for _, num := range nums1 {
        set1[num] = true
    }
    for _, num := range nums2 {
        set2[num] = true
    }
    minCommon := 100
    for num := range set1 {
        if set2[num] {
            if num < minCommon {
                minCommon = num
            }
        }
    }
    if minCommon < 100 {
        return minCommon
    }
    min1 := 100
    for num := range set1 {
        if num < min1 {
            min1 = num
        }
    }
    min2 := 100
    for num := range set2 {
        if num < min2 {
            min2 = num
        }
    }
    if min1 < min2 {
        return min1*10 + min2
    } else {
        return min2*10 + min1
    }
}
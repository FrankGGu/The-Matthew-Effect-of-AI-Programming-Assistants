package main

func twoOutOfThree(nums1 []int, nums2 []int, nums3 []int) []int {
    set1 := make(map[int]bool)
    set2 := make(map[int]bool)
    set3 := make(map[int]bool)
    result := make(map[int]bool)

    for _, num := range nums1 {
        set1[num] = true
    }

    for _, num := range nums2 {
        set2[num] = true
    }

    for _, num := range nums3 {
        set3[num] = true
    }

    for num := range set1 {
        if set2[num] || set3[num] {
            result[num] = true
        }
    }

    for num := range set2 {
        if set1[num] || set3[num] {
            result[num] = true
        }
    }

    for num := range set3 {
        if set1[num] || set2[num] {
            result[num] = true
        }
    }

    res := make([]int, 0, len(result))
    for num := range result {
        res = append(res, num)
    }

    return res
}
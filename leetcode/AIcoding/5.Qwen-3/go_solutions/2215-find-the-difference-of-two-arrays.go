package main

func findDifference(nums1 []int, nums2 []int) [][]int {
    set1 := make(map[int]bool)
    set2 := make(map[int]bool)
    for _, num := range nums1 {
        set1[num] = true
    }
    for _, num := range nums2 {
        set2[num] = true
    }
    var res1 []int
    for num := range set1 {
        if !set2[num] {
            res1 = append(res1, num)
        }
    }
    var res2 []int
    for num := range set2 {
        if !set1[num] {
            res2 = append(res2, num)
        }
    }
    return [][]int{res1, res2}
}
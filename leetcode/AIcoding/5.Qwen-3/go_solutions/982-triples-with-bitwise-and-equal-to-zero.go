package main

func numTriplets(nums1 []int, nums2 []int) int {
    count := func(nums []int) map[int]int {
        m := make(map[int]int)
        for i := 0; i < len(nums); i++ {
            for j := i + 1; j < len(nums); j++ {
                m[nums[i]&nums[j]]++
            }
        }
        return m
    }

    m1 := count(nums1)
    m2 := count(nums2)

    result := 0
    for k, v := range m1 {
        result += v * m2[k]
    }

    return result
}
package main

func subarraysWithKDistinct(nums []int, k int) int {
    return atMostK(nums, k) - atMostK(nums, k-1)
}

func atMostK(nums []int, k int) int {
    count := make(map[int]int)
    left := 0
    res := 0
    for right := 0; right < len(nums); right++ {
        if count[nums[right]] == 0 {
            k--
        }
        count[nums[right]]++
        for k < 0 {
            count[nums[left]]--
            if count[nums[left]] == 0 {
                k++
            }
            left++
        }
        res += right - left + 1
    }
    return res
}
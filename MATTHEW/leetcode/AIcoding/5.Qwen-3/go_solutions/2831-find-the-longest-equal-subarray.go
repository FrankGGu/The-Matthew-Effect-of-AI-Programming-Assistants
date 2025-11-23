package main

func longestEqualSubarray(nums []int, k int) int {
    maxCount := 0
    count := make(map[int]int)
    left := 0
    for right, num := range nums {
        count[num]++
        if count[num] > maxCount {
            maxCount = count[num]
        }
        if right-left+1 - maxCount > k {
            count[nums[left]]--
            left++
        }
    }
    return maxCount
}
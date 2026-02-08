package main

func maxSubarrayCount(nums []int, k int) int {
    count := make(map[int]int)
    left := 0
    result := 0
    maxElement := nums[0]
    for _, num := range nums {
        if num > maxElement {
            maxElement = num
        }
    }
    for right := 0; right < len(nums); right++ {
        count[nums[right]]++
        for count[maxElement] >= k {
            result += len(nums) - right
            count[nums[left]]--
            left++
        }
    }
    return result
}
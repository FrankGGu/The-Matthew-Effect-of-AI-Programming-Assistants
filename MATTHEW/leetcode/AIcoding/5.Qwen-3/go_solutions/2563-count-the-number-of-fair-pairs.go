package main

func countFairPairs(nums []int, target int) int {
    sort.Ints(nums)
    n := len(nums)
    count := 0
    left, right := 0, n-1
    for left < right {
        sum := nums[left] + nums[right]
        if sum < target {
            count += right - left
            left++
        } else {
            right--
        }
    }
    return count
}
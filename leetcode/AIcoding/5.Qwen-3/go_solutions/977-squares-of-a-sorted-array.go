package main

func sortedSquares(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    left, right := 0, n-1
    index := n - 1
    for left <= right {
        if nums[left]*nums[left] > nums[right]*nums[right] {
            result[index] = nums[left] * nums[left]
            left++
        } else {
            result[index] = nums[right] * nums[right]
            right--
        }
        index--
    }
    return result
}
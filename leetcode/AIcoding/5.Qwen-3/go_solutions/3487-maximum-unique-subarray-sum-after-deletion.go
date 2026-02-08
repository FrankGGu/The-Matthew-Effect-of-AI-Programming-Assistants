package main

func maximumUniqueSubarray(nums []int) int {
    maxSum := 0
    left := 0
    sum := 0
    seen := make(map[int]bool)

    for right := 0; right < len(nums); right++ {
        for seen[nums[right]] {
            delete(seen, nums[left])
            sum -= nums[left]
            left++
        }
        seen[nums[right]] = true
        sum += nums[right]
        if sum > maxSum {
            maxSum = sum
        }
    }

    return maxSum
}
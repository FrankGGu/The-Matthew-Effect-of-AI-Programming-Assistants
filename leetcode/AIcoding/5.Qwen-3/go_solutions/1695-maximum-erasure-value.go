package main

func maximumErasureValue(nums []int) int {
    left := 0
    maxSum := 0
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
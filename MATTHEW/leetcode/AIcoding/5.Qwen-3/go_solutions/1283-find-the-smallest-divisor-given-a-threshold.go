package main

func smallestDivisor(nums []int, threshold int) int {
    left := 1
    right := nums[len(nums)-1]

    for left < right {
        mid := (left + right) / 2
        sum := 0
        for _, num := range nums {
            sum += (num + mid - 1) / mid
        }
        if sum > threshold {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}
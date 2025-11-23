package main

func numSubarrayBoundedNonIncreasing(nums []int, left int, right int) int {
    count := 0
    prev := -1
    for i := 0; i < len(nums); i++ {
        if nums[i] < left {
            count += prev + 1
        } else if nums[i] > right {
            prev = -1
        } else {
            prev = i
        }
    }
    return count
}

func numSubarraysBoundedMax(nums []int, left int, right int) int {
    res := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] >= left && nums[i] <= right {
            res += numSubarrayBoundedNonIncreasing(nums[i:], left, right)
        }
    }
    return res
}

func numSubarraysWithBoundariesMax(nums []int) int {
    return numSubarraysBoundedMax(nums, 0, 100000)
}